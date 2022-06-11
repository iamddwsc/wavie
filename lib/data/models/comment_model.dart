import '../../data/models/user.dart';

class CommentModelResult {
  bool? success;
  List<CommentModel>? comments;

  CommentModelResult({this.success, this.comments});

  CommentModelResult.fromJson(Map<String, dynamic> json) {
    this.success = json["success"];
    this.comments = json["results"] == null
        ? null
        : (json["results"] as List)
            .map((e) => CommentModel.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["success"] = this.success;
    if (this.comments != null)
      data["results"] = this.comments?.map((e) => e.toJson()).toList();
    return data;
  }
}

class CommentModel {
  int? commentId;
  int? movieId;
  int? userId;
  String? comment;
  String? createdAt;
  String? updatedAt;
  User? user;

  CommentModel(
      {this.commentId,
      this.movieId,
      this.userId,
      this.comment,
      this.createdAt,
      this.updatedAt,
      this.user});

  CommentModel.fromJson(Map<String, dynamic> json) {
    this.commentId = json["comment_id"];
    this.movieId = json["movieId"];
    this.userId = json["userId"];
    this.comment = json["comment"];
    this.createdAt = json["created_at"];
    this.updatedAt = json["updated_at"];
    this.user = json["user"] == null ? null : User.fromJson(json["user"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["comment_id"] = this.commentId;
    data["movieId"] = this.movieId;
    data["userId"] = this.userId;
    data["comment"] = this.comment;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    if (this.user != null) data["user"] = this.user?.toJson();
    return data;
  }
}
