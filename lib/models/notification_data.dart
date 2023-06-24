class NotificationListModel {
  int id;
  String title;
  String message;
  bool isRead;
  String datetime;

  NotificationListModel({ 
    required this.id,
    required this.title,
    required this.message,
    required this.isRead,
    required this.datetime,
  });

  factory NotificationListModel.fromJson(Map<String, dynamic> _json) {
    return NotificationListModel(
      id: _json['id'],
      title: _json['title'],
      message: _json['message'],
      isRead: _json['isRead'],
      datetime: _json['datetime'],
    );
  }
}