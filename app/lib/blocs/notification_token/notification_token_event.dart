abstract class NotificationTokenEvent {}

class UpdateNotificationTokenEvent extends NotificationTokenEvent {
  UpdateNotificationTokenEvent({
    required this.fcmToken,
  });

  final String? fcmToken;
}
