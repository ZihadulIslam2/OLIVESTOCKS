
import 'package:olive_stocks_flutter/features/portfolio/domains/get_single_user_response_model.dart';

import '../repositories/auth_repository_interface.dart';
import 'auth_service_interface.dart';

class AuthService implements AuthServiceInterface {
  final AuthRepositoryInterface authRepositoryInterface;

  AuthService(this.authRepositoryInterface);

  @override
  Future accessAndRefreshToken(String refreshToken) {
    // TODO: implement accessAndRefreshToken
    throw UnimplementedError();
  }

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
    return await authRepositoryInterface.forgetPassword(email);
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
    return  authRepositoryInterface.isLoggedIn();
  }

  @override
  Future login(String email, String password, {bool google = false, String name = '', String profilePhoto = ''}) async{
    return await authRepositoryInterface.login(email, password, google: google, name: name, profilePhoto: profilePhoto);
  }

  @override
  Future logout() async{
    return await authRepositoryInterface.logout();
  }

  @override
  Future register(String fullName, String email, String phoneNumber, String password, String confirmPassword) async{
    return await authRepositoryInterface.register(fullName, email, phoneNumber, password, confirmPassword);
  }

  @override
  Future resendOtp(String email) async{
    return await authRepositoryInterface.resendOtp(email);
  }

  @override
  Future resetPassword(String token, String email, String newPassword)async {
    return await authRepositoryInterface.resetPassword(token, email, newPassword);
  }

  @override
  Future<bool?> saveUserToken(String token, String refreshToken, String userId) async{
    return await authRepositoryInterface.saveUserToken(token, refreshToken, userId);
  }

  @override
  Future sendOtp({required String phone}) async{
    return await authRepositoryInterface.sendOtp(phone: phone);
  }

  @override
  void setFirstTimeInstall() async{
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
  Future verifyCode(String otp, String email) {
    // TODO: implement verifyCode
    throw UnimplementedError();
  }

  @override
  Future changePassword(String userId, String oldPassword, String newPassword)async{
    return await authRepositoryInterface.changePassword(userId, oldPassword, newPassword);

  }

  @override
  Future emailVerification(String email, String otp) async {
    return await authRepositoryInterface.emailVerification(otp, email);
  }

  @override
  Future getSingleUser(String id) async{
    return await authRepositoryInterface.getSingleUser(id);

  }

  @override
  Future<GetSingleUserResponseModel> getSavedSingleUser() async{
   return await authRepositoryInterface.getSavedSingleUser();
  }

  @override
  Future saveSingleUser(GetSingleUserResponseModel user) async{
    return await authRepositoryInterface.saveSingleUser(user);
  }

  @override
  Future postUpdateProfile({required String name, required String email, required String phoneNumber, required String profilePicture, required String address,required String userId}) async{
    return await authRepositoryInterface.postUpdateProfile(name: name, email: email, phoneNumber: phoneNumber, profilePicture: profilePicture, address: address, userId: userId);
  }

  @override
  Future getWithPaymentSingleUser(String id) async{
    return await authRepositoryInterface.getWithPaymentSingleUser(id);
  }

  @override
  bool isGoogleLoggedIn() {
    return  authRepositoryInterface.isGoogleLoggedIn();
  }







}
