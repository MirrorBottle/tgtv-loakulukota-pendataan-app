class Auth {
  int id;
  String username;
  String name;
  String phoneNumber;
  String email;
  String role;
  String? profileImage;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;
  String bearerToken;

  Auth({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.role,
    required this.phoneNumber,
    required this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
    required this.bearerToken
  });

  factory Auth.fromJson(Map<String, dynamic> _json) {
    return Auth(
      id: _json['id'],
      username: _json['username'],
      name: _json['name'],
      email: _json['email'],
      role: _json['role'],
      phoneNumber: _json['phoneNumber'],
      rememberToken: _json['rememberToken'],
      createdAt: _json['createdAt'],
      updatedAt: _json['updatedAt'],
      bearerToken: _json['bearerToken'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'role': role,
      'email': email,
      'phoneNumber': phoneNumber,
      'rememberToken': rememberToken,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'bearerToken': bearerToken,
    };
  }
}
