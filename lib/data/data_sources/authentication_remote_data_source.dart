import 'package:wavie/data/core/api_client.dart';

import '../../common/constants/api_constants.dart';
import '../models/user.dart';

abstract class AuthenticationRemoteDataSource {
  /// Throws [ServerException] for all error codes.
  Future<UserModelResult> signIn(Map<String, dynamic> requestBody);
  Future<UserModelResult> signUp(Map<String, dynamic> requestBody);
  Future<String> signOut(String token);
  Future<String> refreshToken(String token);
  Future<User> updateUser(Map<String, dynamic> requestBody);
}

class AuthenticationRemoteDataSourceImpl
    extends AuthenticationRemoteDataSource {
  final ApiClient _client;

  AuthenticationRemoteDataSourceImpl(this._client);

  @override
  Future<String> refreshToken(String token) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future<UserModelResult> signIn(Map<String, dynamic> requestBody) async {
    // TODO: implement signIn
    //print('ards: ' + requestBody.toString());
    final response = await _client.post(
      Uri.parse(ApiConstants.BASE_URL + ApiConstants.SIGN_IN),
      params: requestBody,
    );
    //print(response);
    return UserModelResult.fromJson(response);
  }

  @override
  Future<String> signOut(String token) async {
    // TODO: implement signOut
    final response = await _client.get(
      Uri.parse(ApiConstants.BASE_URL + ApiConstants.SIGN_OUT),
      token: token,
    );
    return response['message'];
  }

  @override
  Future<UserModelResult> signUp(Map<String, dynamic> requestBody) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<User> updateUser(Map<String, dynamic> requestBody) async {
    // TODO: implement updateUser
    final response = await _client.postWithImage(
      Uri.parse(ApiConstants.BASE_URL + ApiConstants.UPDATE_USER),
      params: requestBody,
    );
    //print(response);
    return UserModelResult.fromJson(response).user!;
  }
}
