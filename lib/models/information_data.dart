class InformationModel {
  String title;
  String value;
  String icon;
  String redirect;

  InformationModel({ 
    required this.title,
    required this.value,
    required this.icon,
    required this.redirect,
  });

  factory InformationModel.fromJson(Map<String, dynamic> _json) {
    return InformationModel(
      title: _json['title'],
      value: _json['value'],
      icon: _json['icon'],
      redirect: _json['redirect'],
    );
  }
}