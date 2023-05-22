import 'dart:async';

import 'package:baby_guard/blocs/auth/auth_bloc.dart';
import 'package:baby_guard/blocs/auth/auth_state.dart';
import 'package:baby_guard/blocs/notification/notification_bloc.dart';
import 'package:baby_guard/blocs/notification/notification_event.dart';
import 'package:baby_guard/blocs/notification/notification_state.dart';
import 'package:baby_guard/blocs/notification_token/notification_token_event.dart';
import 'package:baby_guard/blocs/notification_token/notification_token_bloc.dart';
import 'package:baby_guard/pages/main_page.dart';
import 'package:baby_guard/utils/utils.dart';
import 'package:baby_guard/widgets/base_scaffold.dart';
import 'package:baby_guard/widgets/loading_indicator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({
    super.key,
    this.isMain = false,
    this.floatingActionButton,
    required this.child,
  });

  final bool isMain;
  final Widget child;
  final Widget? floatingActionButton;

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  StreamSubscription<String>? _fcmTokenSubscription;
  StreamSubscription<RemoteMessage>? _fcmMessageSubscription;

  void _handleFcmForegroundMessage(RemoteMessage message) {
    BlocProvider.of<NotificationBloc>(context).add(
      NewNotificationEvent(
        title: message.notification?.title ?? 'Atenção',
        body: message.notification?.body ?? 'Nova notificação.',
      ),
    );
  }

  void _handleFcmTokenRefresh(String? fcmToken) {
    BlocProvider.of<NotificationTokenBloc>(context)
        .add(UpdateNotificationTokenEvent(fcmToken: fcmToken));
  }

  @override
  void initState() {
    super.initState();

    if (!widget.isMain) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        if (BlocProvider.of<AuthBloc>(context).state is AuthInitialState) {
          await Utils.replaceNavigation(context, MainPage.route);
        } else {
          if (kDebugMode) {
            print('attaching fcm handlers');
          }

          setState(() {
            _fcmTokenSubscription = FirebaseMessaging.instance.onTokenRefresh
                .listen(_handleFcmTokenRefresh);

            _fcmMessageSubscription =
                FirebaseMessaging.onMessage.listen(_handleFcmForegroundMessage);
          });
        }
      });

      Future(() async {
        final fcmToken = await FirebaseMessaging.instance.getToken();

        _handleFcmTokenRefresh(fcmToken);
      });
    }
  }

  @override
  void dispose() {
    if (kDebugMode) {
      print('detaching fcm handlers');
    }

    _fcmTokenSubscription?.cancel();
    _fcmMessageSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is AuthInitialState) {
              await Utils.replaceNavigation(context, MainPage.route);
            }
          },
        ),
        BlocListener<NotificationBloc, NotificationState>(
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.black),
                    ),
                    Text(state.body),
                  ],
                ),
              ),
            );
          },
        ),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthErrorState) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(64),
                child: Text(state.message, textAlign: TextAlign.center),
              ),
            );
          }

          if (state is AuthDoneState) {
            return BaseScaffold(
              floatingActionButton: widget.floatingActionButton,
              child: widget.child,
            );
          }

          return const Scaffold(body: LoadingIndicator());
        },
      ),
    );
  }
}
