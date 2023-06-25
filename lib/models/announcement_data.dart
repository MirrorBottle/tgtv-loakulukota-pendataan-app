class AnnouncementModel {
  int id;
  String title;
  String content;
  String activityDate;

  AnnouncementModel({ 
    required this.id,
    required this.title,
    required this.content,
    required this.activityDate,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> _json) {
    return AnnouncementModel(
      id: _json['id'],
      title: _json['title'],
      content: _json['content'],
      activityDate: _json['activityDate'],
    );
  }
}