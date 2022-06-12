import '../../data/models/user.dart';

abstract class AuthenticationRepository {
  Future<User> signInUser(Map<String, dynamic> requestBody);
  Future<String> signOutUser(String token);
  Future<User> updateUser(Map<String, dynamic> requestBody);
}
