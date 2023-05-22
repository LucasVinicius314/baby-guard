abstract class NotificationEvent {}

class NewNotificationEvent extends NotificationEvent {
  NewNotificationEvent({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;
}
