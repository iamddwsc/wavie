import 'dart:io';

import 'package:wavie/data/core/unauthorised_exception.dart';
import 'package:wavie/data/data_sources/authentication_local_data_source.dart';
import 'package:wavie/data/data_sources/authentication_remote_data_source.dart';

import '../../domain/entities/app_error.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../models/user.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource remoteDataSource;
  final AuthenticationLocalDataSource localDataSource;

  AuthenticationRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<User> signInUser(Map<String, dynamic> requestBody) async {
    // TODO: implement signInUser
    try {
      final signInResponse = await remoteDataSource.signIn(requestBody);
      if (signInResponse.token != null) {
        await localDataSource.saveToken(
            signInResponse.token!, signInResponse.expiresAt!);
        try {
          localDataSource.saveMyUser(signInResponse.user!);
        } catch (e) {
          print(e);
        }
      }
      //print(signInResponse);
      return signInResponse.user!;
      //return signInResponse;
    } on SocketException {
      return Future.error(AppErrorType.networkError);
    } on UnauthorisedException {
      return Future.error(AppErrorType.unauthorisedError);
    } on Exception {
      return Future.error(AppErrorType.networkError);
    }
  }

  @override
  Future<String> signOutUser(String token) async {
    try {
      final signOutResponse = await remoteDataSource.signOut(token);
      return signOutResponse;
      //print(signInResponse);
      //return signOutResponse;
      //return signInResponse;
    } on SocketException {
      return Future.error(AppErrorType.networkError);
    } on UnauthorisedException {
      return Future.error(AppErrorType.unauthorisedError);
    } on Exception {
      return Future.error(AppErrorType.networkError);
    }
  }

  @override
  Future<User> updateUser(Map<String, dynamic> requestBody) async {
    // TODO: implement updateUser
    try {
      final signInResponse = await remoteDataSource.updateUser(requestBody);
      if (signInResponse.userId != null) {
        try {
          localDataSource.saveMyUser(signInResponse);
        } catch (e) {
          print(e);
        }
      }
      //print(signInResponse);
      return signInResponse;
      //return signInResponse;
    } on SocketException {
      return Future.error(AppErrorType.networkError);
    } on UnauthorisedException {
      return Future.error(AppErrorType.unauthorisedError);
    } on Exception {
      return Future.error(AppErrorType.networkError);
    }
  }
}
