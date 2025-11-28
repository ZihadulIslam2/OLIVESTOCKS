
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olive_stocks_flutter/features/portfolio/domains/get_single_user_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/contants/urls.dart';
import '../../../helpers/remote/data/api_client.dart';
import '../../../utils/app_constants.dart';
import 'auth_repository_interface.dart';

class AuthRepository implements AuthRepositoryInterface {
  final ApiClient apiClient;

  final SharedPreferences sharedPreferences;

  AuthRepository({required this.apiClient, required this.sharedPreferences});




  @override
  bool clearSharedAddress() {
    // TODO: implement clearSharedAddress
    throw UnimplementedError();
  }

  @override
  Future<bool> clearUserCredentials() {
    // TODO: implement clearUserCredentials
    throw UnimplementedError();
  }

  @override
  Future forgetPassword(String? email) async{
    return await apiClient.postData(Urls.forgetPassword, {
      'email': email,
    });
  }

  @override
  String getUserToken() {
    // TODO: implement getUserToken
    throw UnimplementedError();
  }

  @override
  bool isFirstTimeInstall() {
    // TODO: implement isFirstTimeInstall
    throw UnimplementedError();
  }

  @override
  bool isLoggedIn() {
    String? val = sharedPreferences.getString(AppConstants.token);
    bool isLoggedIn = sharedPreferences.getBool('IsLoggedIn') ?? false;
    if (isLoggedIn) {
      return true;
    }
    return false;
  }
  @override
  Future login(String email, String password, {bool google = false, String name = "", String profilePhoto = ""}) async{
    debugPrint("Last step : $name  google${google}, $profilePhoto");
    return await apiClient.postData(Urls.login, {
      'email': email,
      'password': password,
      'gLogin' : google,
      'name': name,
      'profilePhoto' : profilePhoto,
    });
  }

  @override
  Future logout() async{
    return await apiClient.postData(Urls.logOut, {});
  }

  @override
  Future register(String fullName, String email, String phoneNumber, String password,
      String confirmPassword) async{
    return await apiClient.postData(Urls.register, {
      'userName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'confirmPassword': confirmPassword,
    });
  }

  @override
  Future resendOtp(String email) {
    // TODO: implement resendOtp
    throw UnimplementedError();
  }

  @override
  Future resetPassword(String token, String email, String newPassword) async{
    return await apiClient.postData(Urls.resetPassword, {
      'email': email,
      'otp': token,
      'password': newPassword,
    });
  }

  @override
  Future<bool?> saveUserToken(String token, String refreshToken, String userId) async {
    print(
      'User Token ${token.toString()} ================================== from Repository ',
    );

    apiClient.token = token;
    apiClient.updateHeader(token);

    await sharedPreferences.setString(AppConstants.userId, userId);
    await sharedPreferences.setString(AppConstants.refreshToken, refreshToken);
    return await sharedPreferences.setString(AppConstants.token, token);

  }

  @override
  Future sendOtp({required String phone}) {
    // TODO: implement sendOtp
    throw UnimplementedError();
  }

  @override
  void setFirstTimeInstall() {
    // TODO: implement setFirstTimeInstall
  }

  @override
  Future updateAccessAndRefreshToken() {
    // TODO: implement updateAccessAndRefreshToken
    throw UnimplementedError();
  }

  @override
  Future updateToken() {
    // TODO: implement updateToken
    throw UnimplementedError();
  }

  @override
  Future verifyCode(String otp, String email) async {

  }

  @override
  Future accessAndRefreshToken(String refreshToken) {
    // TODO: implement accessAndRefreshToken
    throw UnimplementedError();
  }

  @override
  Future changePassword(String userId, String oldPassword, String newPassword) async {
    return await apiClient.postData(Urls.changePassword, {
      'userId': userId,
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    });
  }

  @override
  Future emailVerification(String email, String otp) async{

    print('Email $email OTP $otp from repository' );

    return await apiClient.postData(Urls.emailVerification,
      {
        "email": otp,
        "otp": email
      }
    );

  }

  @override
  Future getSingleUser(String id) async {
    return await apiClient.getData(Urls.getSingleUser+id);

  }

  @override
  Future<GetSingleUserResponseModel> getSavedSingleUser() async{
    var data = sharedPreferences.getString('singleUser');
    var json = jsonDecode(data!);
    return GetSingleUserResponseModel.fromJson(json);
  }

  @override
  Future saveSingleUser(GetSingleUserResponseModel user) async{
    await sharedPreferences.setString('singleUser', jsonEncode(user));
    return Future.value(true);
  }

  @override
  Future postUpdateProfile({required String name, required String email, required String phoneNumber, required String profilePicture, required String address,required String userId}) async{
    return await apiClient.postData(Urls.postUpdateUser, {
      'userId': userId,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'address': address,
    });
  }

  @override
  Future<dynamic> getWithPaymentSingleUser(String id) async{
    return await apiClient.getData(Urls.getWithPaymentSingleUser+id);
  }

  @override
  bool isGoogleLoggedIn() {
    String? val = sharedPreferences.getString(AppConstants.token);
    bool isLoggedIn = sharedPreferences.getBool('IsLoggedIn') ?? false;
    if (isLoggedIn) {
      return true;
    }
    return false;
  }

}

