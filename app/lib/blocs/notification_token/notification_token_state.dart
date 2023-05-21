abstract class NotificationTokenState {}

class NotificationTokenInitialState extends NotificationTokenState {}

// UpdateNotificationToken

class UpdateNotificationTokenLoadingState extends NotificationTokenState {}

class UpdateNotificationTokenDoneState extends NotificationTokenState {}

class UpdateNotificationTokenErrorState extends NotificationTokenState {
  UpdateNotificationTokenErrorState({
    required this.message,
  });

  final String message;
}
