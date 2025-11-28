
import '../../portfolio/domains/get_single_user_response_model.dart';

abstract class AuthServiceInterface {
  Future<dynamic> login(String email,  String password, {bool google, String name, String profilePhoto});
  Future<dynamic> register(String fullName, String email, String phoneNumber, String password, String confirmPassword);
  Future<dynamic> logout();
  Future<dynamic> accessAndRefreshToken(String refreshToken);
  Future<dynamic> forgetPassword(String? email);
  Future<dynamic> verifyCode( String otp ,  String email);
  Future<dynamic> resendOtp(String email);
  Future<dynamic> sendOtp({required String phone});
  Future<dynamic> resetPassword(String token, String email, String newPassword);
  Future<dynamic> changePassword(String userId, String oldPassword, String newPassword);

  Future<dynamic> emailVerification(String email, String otp);

  bool isLoggedIn();
  bool isGoogleLoggedIn();
  Future<bool> clearUserCredentials();
  bool clearSharedAddress();
  String getUserToken();

  Future<dynamic> updateToken();
  Future<bool?> saveUserToken(String token, String refreshToken, String userId);
  Future<dynamic> updateAccessAndRefreshToken();

  bool isFirstTimeInstall();
  void setFirstTimeInstall();

  Future<dynamic> getSingleUser(String id);

  Future<dynamic> getWithPaymentSingleUser(String id);

  Future<dynamic> saveSingleUser(GetSingleUserResponseModel user);

  Future<GetSingleUserResponseModel> getSavedSingleUser();

  Future<dynamic> postUpdateProfile({
   required String userId,
    required String name,
    required String email,
    required String phoneNumber,
    required String profilePicture,
    required String address,
  });


}

