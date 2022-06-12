import 'package:hive_flutter/adapters.dart';

import '../models/user.dart';

abstract class AuthenticationLocalDataSource {
  //Future<String> getToken();
  Future<void> saveToken(String token, String expiresAt);
  //Future<void> deleteToken();
  Future<void> saveMyUser(User myUser);
}

class AuthenticationLocalDataSourceImpl
    implements AuthenticationLocalDataSource {
  // AuthenticationLocalDataSourceImpl(Object object);

  // @override
  // Future<String> getToken() async {
  //   return '';
  // }

  @override
  Future<void> saveToken(String token, String expiresAt) async {
    final authenticationBox = await Hive.openBox<String>('authenticationBox');
    await authenticationBox.put('token', token);
    return await authenticationBox.put('expiresAt', expiresAt);
  }

  @override
  Future<void> saveMyUser(User myUser) {
    final userBox = Hive.box<User>('myUserBox');
    if (userBox.get('myUser') == null) {
      return userBox.put('myUser', myUser);
    } else {
      userBox.delete('myUser');
      return userBox.put('myUser', myUser);
    }
  }
}
