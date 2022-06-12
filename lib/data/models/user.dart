import 'package:hive/hive.dart';

part 'user.g.dart';

class UserModelResult {
  bool? success;
  String? token;
  User? user;
  String? expiresAt;

  UserModelResult({this.success, this.token, this.user, this.expiresAt});

  UserModelResult.fromJson(Map<String, dynamic> json) {
    this.success = json["success"];
    this.token = json["token"];
    this.user = json["user"] == null ? null : User.fromJson(json["user"]);
    this.expiresAt = json["expires_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["success"] = this.success;
    data["token"] = this.token;
    if (this.user != null) data["user"] = this.user?.toJson();
    data["expires_at"] = this.expiresAt;
    return data;
  }
}

@HiveType(typeId: 3)
class User {
  @HiveField(0)
  int? userId;
  @HiveField(1)
  String? firstName;
  @HiveField(2)
  String? lastName;
  @HiveField(3)
  String? photo;
  @HiveField(4)
  String? email;
  @HiveField(5)
  String? emailVerifiedAt;
  @HiveField(6)
  String? createdAt;
  @HiveField(7)
  String? updatedAt;

  User(
      {this.userId,
      this.firstName,
      this.lastName,
      this.photo,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    this.userId = json["userId"];
    this.firstName = json["first_name"];
    this.lastName = json["last_name"];
    this.photo = json["photo"];
    this.email = json["email"];
    this.emailVerifiedAt = json["email_verified_at"];
    this.createdAt = json["created_at"];
    this.updatedAt = json["updated_at"];
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
