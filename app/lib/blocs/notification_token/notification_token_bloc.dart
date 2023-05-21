import 'package:baby_guard/blocs/notification_token/notification_token_event.dart';
import 'package:baby_guard/blocs/notification_token/notification_token_state.dart';
import 'package:baby_guard/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationTokenBloc
    extends Bloc<NotificationTokenEvent, NotificationTokenState> {
  NotificationTokenBloc({required this.userRepository})
      : super(NotificationTokenInitialState()) {
    on<UpdateNotificationTokenEvent>((event, emit) async {
      try {
        emit(UpdateNotificationTokenLoadingState());

        await userRepository.updateNotificationToken(fcmToken: event.fcmToken);

        emit(UpdateNotificationTokenDoneState());
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }

        emit(UpdateNotificationTokenErrorState(message: e.toString()));
      }
    });
  }

  final UserRepository userRepository;
}
