import 'package:baby_guard/blocs/notification/notification_event.dart';
import 'package:baby_guard/blocs/notification/notification_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(const NotificationState(body: '', title: '')) {
    on<NewNotificationEvent>((event, emit) async {
      emit(NotificationState(
        title: event.title,
        body: event.body,
      ));
    });
  }
}
