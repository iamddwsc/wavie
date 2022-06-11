class UserEntity {
  final int? userId;
  final String? first_name;
  final String? last_name;
  final String? photo_url;

  const UserEntity({
    required this.userId,
    required this.first_name,
    required this.last_name,
    required this.photo_url,
  });

  List<Object> get probs => [userId!, photo_url!, first_name!, last_name!];

  bool get stringify => true;
}
