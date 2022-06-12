class SignInRequestParams {
  final String userName;
  final String password;

  SignInRequestParams({required this.userName, required this.password});

  Map<String, dynamic> toJson() => {
        'email': userName,
        'password': password,
      };
}
