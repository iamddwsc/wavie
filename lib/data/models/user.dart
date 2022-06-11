import 'package:wavie/domain/entities/user_entity.dart';

class UserModelResult {
  bool? success;
  String? token;
  User? user;

  UserModelResult({this.success, this.token, this.user});

  UserModelResult.fromJson(Map<String, dynamic> json) {
    this.success = json["success"];
    this.token = json["token"];
    this.user = json["user"] == null ? null : User.fromJson(json["user"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["success"] = this.success;
    data["token"] = this.token;
    if (this.user != null) data["user"] = this.user?.toJson();
    return data;
  }
}

class User extends UserEntity {
  int? userId;
  String? firstName;
  String? lastName;
  String? photo;
  String email;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;

  User(
      {required this.userId,
      required this.firstName,
      required this.lastName,
      required this.photo,
      this.email = '',
      this.emailVerifiedAt = '',
      this.createdAt = '',
      this.updatedAt = ''})
      : super(
            userId: userId,
            first_name: firstName,
            last_name: lastName,
            photo_url: photo);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json["userId"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      photo: json["photo"] ?? '',
      email: json["email"],
      emailVerifiedAt: json["email_verified_at"] ?? '',
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["userId"] = this.userId;
    data["first_name"] = this.firstName;
    data["last_name"] = this.lastName;
    data["photo"] = this.photo;
    data["email"] = this.email;
    data["email_verified_at"] = this.emailVerifiedAt;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    return data;
  }
}
