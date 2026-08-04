class NotificationModel {
  int notificationId;
  String channelID;
  String channelName;
  String title;
  String body;
  String payload;


  NotificationModel({
    required this.notificationId,
    required this.channelID,
    required this.channelName,
    required this.title,
    required this.body,
    required this.payload,
});
}