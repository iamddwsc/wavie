class UpdateUserParams {
  final String last_name;
  final String first_name;
  final String filepath;
  final String token;

  UpdateUserParams({
    required this.last_name,
    required this.first_name,
    required this.filepath,
    required this.token,
  });

  Map<String, dynamic> toJson() => {
        'last_name': last_name,
        'first_name': first_name,
        'filepath': filepath,
        'token': token,
      };
}
