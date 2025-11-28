import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olive_stocks_flutter/features/auth/presentations/screens/email_varification_screen.dart';
import 'package:olive_stocks_flutter/features/auth/presentations/screens/login_screen.dart';
import 'package:olive_stocks_flutter/payment/services/stripe_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/screens/NabScreen.dart';
import '../../../helpers/custom_snackbar.dart';
import '../../../helpers/remote/data/api_checker.dart';
import '../../../helpers/remote/data/api_client.dart';
import '../../../utils/app_constants.dart';
import '../../experts/presentations/screens/user_profile_screen.dart';
import '../../portfolio/controller/portfolio_controller.dart';
import '../../portfolio/domains/get_single_user_response_model.dart';
import '../../portfolio/domains/post_update_user_profile_response_model.dart';
import '../domain/model/login_response_model.dart';
import '../domain/model/register_response_model.dart';
import '../presentations/screens/code_verify_screen.dart';
import '../presentations/screens/create_new_password_screen.dart';
import '../sevices/auth_service_interface.dart';

import 'package:http/http.dart' as http;

class AuthController extends GetxController implements GetxService {
  final AuthServiceInterface authServiceInterface;
 final StripeService  service;
  AuthController({required this.authServiceInterface, required this.service});

  bool _isLoading = false;
  bool _acceptTerms = false;

  bool get isLoading => _isLoading;

  bool get acceptTerms => _acceptTerms;
  final String _mobileNumber = '';

  String get mobileNumber => _mobileNumber;
  XFile? _pickedProfileFile;

  XFile? get pickedProfileFile => _pickedProfileFile;
  XFile identityImage = XFile('');
  List<XFile> identityImages = [];
  List<MultipartBody> multipartList = [];
  String countryDialCode = '+880';
  String email = '';

  var isUpdateProfileLoading = false.obs;

  bool isVerificationLoading = false;

  void setCountryCode(String code) {
    countryDialCode = code;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    loadPaymentStatusFromLocal();
  }


  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController identityNumberController = TextEditingController();

  FocusNode fNameNode = FocusNode();
  FocusNode lNameNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode addressNode = FocusNode();
  FocusNode identityNumberNode = FocusNode();

  LoginResponseModel logInResponseModel = LoginResponseModel();
  late RegisterResponseModel registerResponseModel;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  UpdateUserResponseModel updateUserResponseModel = UpdateUserResponseModel();

  void addImageAndRemoveMultiParseData() {
    multipartList.clear();
    identityImages.clear();
    update();
  }

  Future<void> saveProfileImageToPrefs(XFile pickedImage, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image_path_$email', pickedImage.path);
  }


  bool isPremium() {
    final paymentStatus = getSingleUserResponseModel?.payment?.toLowerCase() ?? 'Free';
    return paymentStatus == 'Premium' || paymentStatus == 'Ultimate';
  }




// update user profile
  void pickImage(bool bool, bool Bool) async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (selectedImage != null) {
      _pickedProfileFile = selectedImage;
      update(); // Update UI
    }
  }



  Future<void> postUpdateProfile(
    String name,
    String email,
    String phoneNumber,
    String address,
    String? imagePath,
    String userId,
  ) async {
    isUpdateProfileLoading.value = true;

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        'https://backend-rafi-hzi9.onrender.com/api/v1/user/update-user',
      ),
    );

    request.fields.addAll({
      'id': userId,
      'fullName': name,
      'phoneNumber': phoneNumber,
      'address': address,
      'email': email,
    });

    if (imagePath != null) {
      request.files.add(
        await http.MultipartFile.fromPath('imageLink', imagePath),
      );
    }

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      final resBody = await response.stream.bytesToString();
      print('✅ Profile updated: $resBody');
      isUpdateProfileLoading.value = false;
      Get.back(); // or navigate to profile screen
    } else {
      print('❌ Failed to update: ${response.reasonPhrase}');
      isUpdateProfileLoading.value = false;
    }
  }

  void removeImage(int index) {
    identityImages.removeAt(index);
    multipartList.removeAt(index);
    update();
  }

  final List<String> _identityTypeList = ['passport', 'driving_license', 'nid'];

  List<String> get identityTypeList => _identityTypeList;
  String _identityType = '';

  String get identityType => _identityType;

  void setIdentityType(String setValue) {
    _identityType = setValue;
    update();
  }

  Future<void> login(String email, String password) async {
    _isLoading = true;
    update();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Response? response = await authServiceInterface.login(email, password);
    if (response != null && response.statusCode == 200) {
      logInResponseModel = LoginResponseModel.fromJson(response.body);

      String token = logInResponseModel.data!.token!.accessToken!;
      String refreshToken = logInResponseModel.data!.token!.refreshToken!;
      String userId = logInResponseModel.data!.user!.sId!;

      // Save tokens & userId as needed
      await setUserToken(token, refreshToken, userId);

      // ✅ Fetch latest user profile right away
      await getSingleUser(userId);

      getUserPaymentExpiryDate(userId);

      DateTime expireDate = DateTime.parse(getSingleUserResponseModel!.expiryDate);
      service.saveExpireDate(expireDate);

      var portfolioController = Get.find<PortfolioController>();
      if (isLoggedIn()) {
        await portfolioController.getPortfolio();
      }

      Future.delayed(const Duration(seconds: 2));
      Get.offAll(NavScreen());

      sharedPreferences.setBool('IsLoggedIn', true);

      _isLoading = false;
    } else if (response != null && response.statusCode == 202) {
      if (response.body['data']['is_phone_verified'] == 0) {}
    } else if (response != null && response.statusCode == 400) {
      Get.offAll(() {});
    } else {
      _isLoading = false;
      ApiChecker.checkApi(response!);
    }

    _isLoading = false;
    update();
  }





  Future<void> saveSingleUser(GetSingleUserResponseModel user) async {
    return await authServiceInterface.saveSingleUser(user);
  }

  Future<GetSingleUserResponseModel> getSaveSingleUser() async {
    return await authServiceInterface.getSavedSingleUser();
  }

  bool isLoggedIn() {
    return authServiceInterface.isLoggedIn();
  }
  bool isGoogleLoggedIn() {
    return authServiceInterface.isGoogleLoggedIn();
  }

  Future<bool> isFirstTimeInstall() async {
    if (await getFirsTimeInstall()) {
      return true;
    } else {
      return false;
    }
  }

  bool logging = false;

  Future<void> logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    logging = true;
    update();

    _googleSignIn.signOut();
    _googleSignIn.disconnect();
    service.deleteExpireDate();


    Response? response = await authServiceInterface.logout();

    if (isLoggedIn() == true) {
      if (response!.statusCode == 200) {
        // ⚠️ Do NOT remove profile image path
        await preferences.setString(AppConstants.token, '');
        await preferences.setString(AppConstants.refreshToken, '');
        await preferences.setBool('IsLoggedIn', false);
        Get.to(LoginScreen());
        // showCustomSnackBar('You have logout Successfully');
      } else {
        logging = false;
        ApiChecker.checkApi(response);
      }
    }
    update();
  }

  Future<void> permanentDelete() async {
    logging = true;
    update();

    update();
  }

  Future<void> register(
    String fullName,
    String email,
    String phoneNumber,
    String password,
    String confirmPassword,
  ) async {
    _isLoading = true;
    update();

    Response? response = await authServiceInterface.register(
      fullName,
      email,
      phoneNumber,
      password,
      confirmPassword,
    );

    if (response!.statusCode == 201) {
      registerResponseModel = RegisterResponseModel.fromJson(response.body);
      // showCustomSnackBar('Registered! Now verify your email.');

      // 👇 Navigate to OTP screen with email
      Get.to(() => EmailVerificationScreen(otp: email));
    } else {
      _isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<Response> sendOtp({
    required String countryCode,
    required String phone,
  }) async {
    _isLoading = true;
    update();

    Response? response = Response();

    update();
    return response;
  }

  Future<void> otpVerification(String otp, String email) async {
    _isLoading = true;
    update();
    Response? response = await authServiceInterface.verifyCode(otp, email);
    if (response!.body['status'] == true) {
      // showCustomSnackBar('Otp verification has been successful');
      Get.to(CreateNewPasswordScreen(otp: otp, email: email));
    } else {
      showCustomSnackBar('There is a problem in sending OTP');
      // Get.find<AuthController>().logOut();
    }

    update();
  }

  Future<void> emailVerification(String otp, String email) async {
    isVerificationLoading = true;
    print('Email $email OTP $otp');
    try {
      Response? response = await authServiceInterface.emailVerification(
        otp,
        email,
      );

      if (response != null && response.statusCode == 200) {
        // showCustomSnackBar('OTP verification successful!');
        Get.to(() => LoginScreen());
      } else {
        print(response.toString());
        // showCustomSnackBar('OTP verification failed!');
      }
    } catch (e) {
      // showCustomSnackBar('Something went wrong: $e');
    }

    isVerificationLoading = false;
    update();
  }

  // Future<void> resendOtp(String email) async {
  //   _isLoading = true;
  //   update();
  //   Response? response = await authServiceInterface.resendOtp(email);
  //   if (response!.body['status'] == true) {
  //     showCustomSnackBar('Otp has been successful to your mail');
  //
  //     Get.to(OtpScreen());
  //   }
  //
  //   update();
  // }

  Future<void> forgetPassword(String emails) async {
    email = emails;
    _isLoading = true;
    update();

    Response? response = await authServiceInterface.forgetPassword(emails);

    if (response?.statusCode == 200) {
      _isLoading = false;
      showCustomSnackBar('successfully sent otp');
      Get.to(CodeVerifyScreen(email: emails));
    } else {
      _isLoading = false;
      // showCustomSnackBar('invalid mail');
    }
    update();
  }

  Future<void> resetPassword(
    String token,
    String email,
    String newPassword,
  ) async {
    _isLoading = true;

    update();

    Response? response = await authServiceInterface.resetPassword(
      token,
      email,
      newPassword,
    );
    if (response!.statusCode == 200) {
      // SnackBarWidget('password_change_successfully'.tr, isError: false);
      // showCustomSnackBar('Password Change Successfully');
      Get.offAll(() => const LoginScreen());
    } else {
      // showCustomSnackBar('Password Change was  Unsuccessfully');
      ApiChecker.checkApi(response);
    }

    _isLoading = false;

    update();
  }

  Future<void> changePassword(String password, String newPassword) async {
    _isLoading = true;
    update();

    Response? response = await authServiceInterface.resetPassword(
      '',
      password,
      newPassword,
    );
    if (response!.statusCode == 200) {
      showCustomSnackBar('Password Change Successfully');
      logOut();
      Get.offAll(() => const LoginScreen());
    } else {
      ApiChecker.checkApi(response);
    }

    _isLoading = false;
    update();
  }

  bool updateFcm = false;

  Future<void> updateAccessAndRefreshToken() async {
    Response? response =
        await authServiceInterface.updateAccessAndRefreshToken();
    if (response?.statusCode == 200) {
      String token = response!.body['accessToken'];
      String refreshToken = response.body['refreshToken'];

      print('accessToken $token NOWW');
      print('refreshToken $refreshToken');

      setUserToken(token, refreshToken, '');
      updateFcm = false;
    } else {
      updateFcm = false;
      ApiChecker.checkApi(response!);
    }

    update();
  }

  String _verificationCode = '';
  String _otp = '';

  String get otp => _otp;

  String get verificationCode => _verificationCode;

  void updateVerificationCode(String query) {
    _verificationCode = query;
    if (_verificationCode.isNotEmpty) {
      _otp = _verificationCode;
    }
    update();
  }

  void clearVerificationCode() {
    updateVerificationCode('');
    _verificationCode = '';
    update();
  }

  bool _isActiveRememberMe = false;

  bool get isActiveRememberMe => _isActiveRememberMe;

  String get confirmPassword => '';

  void toggleTerms() {
    _acceptTerms = !_acceptTerms;
    update();
  }

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }

  void setRememberMe() {
    _isActiveRememberMe = true;
  }

  String getUserToken() {
    return authServiceInterface.getUserToken();
  }

  Future<void> setUserToken(
    String token,
    String refreshToken,
    String userId,
  ) async {
    authServiceInterface.saveUserToken(token, refreshToken, userId);
  }

  Future<bool> getFirsTimeInstall() async {
    return authServiceInterface.isFirstTimeInstall();
  }

  void setFirstTimeInstall() {
    return authServiceInterface.setFirstTimeInstall();
  }

  bool isSingleUserLoading = false;
  GetSingleUserResponseModel? getSingleUserResponseModel =
      GetSingleUserResponseModel();

  /// Fetch the user profile data from backend
  Future<void> getSingleUser(String id) async {
    isSingleUserLoading = true;
    update();

    try {
      Response? response = await authServiceInterface.getSingleUser(id);
      if (response != null && response.statusCode == 200) {
        getSingleUserResponseModel = GetSingleUserResponseModel.fromJson(response.body);
        authServiceInterface.saveSingleUser(getSingleUserResponseModel!);

        print('User payment status: ${getSingleUserResponseModel!.payment}');

        final paymentStatus = getSingleUserResponseModel?.payment ?? 'free';
        print('User payment status: $paymentStatus');

        isPaidUser.value = paymentStatus.toLowerCase() != 'free';
        print('✅ isPaidUser set to: ${isPaidUser.value}');

        // ✅ Save to SharedPreferences
        await savePaymentStatusLocally(paymentStatus);
        service.saveExpireDate(getSingleUserResponseModel!.expiryDate!);
      } else if (response != null) {
        ApiChecker.checkApi(response);
      } else {
        print('getSingleUser: response is null');
      }
    } catch (e) {
      print('Error in getSingleUser: $e');
    } finally {
      isSingleUserLoading = false;
      update();
    }
  }



  //paid user
  RxBool isPaidUser = false.obs;




  Future<void> savePaymentStatusLocally(String status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_payment_status', status);
    // treat any paid tier as true
    final normalized = status.toLowerCase();
    isPaidUser.value = normalized == 'subscriber' || normalized == 'premium' || normalized == 'ultimate';
  }

  Future<void> loadPaymentStatusFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final status = prefs.getString('user_payment_status') ?? 'free';
    final normalized = status.toLowerCase();
    isPaidUser.value = normalized == 'subscriber' || normalized == 'premium' || normalized == 'ultimate';
  }



  bool isAnyLoggedIn() {
    return isLoggedIn() || isGoogleLoggedIn();
  }

  /// [Google Sign In]
  Future<void> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
      if (googleAccount == null) return; // User canceled

      final photoUrl = googleAccount.photoUrl ?? "";

      // Authenticate with your backend
      Response? response = await authServiceInterface.login(
        googleAccount.email,
        googleAccount.id,
        google: true,
        name: googleAccount.displayName ?? "",
        profilePhoto: photoUrl,
      );

      if (response != null && response.statusCode == 200) {
        logInResponseModel = LoginResponseModel.fromJson(response.body);

        final token = logInResponseModel.data!.token!.accessToken!;
        final refreshToken = logInResponseModel.data!.token!.refreshToken!;
        final userId = logInResponseModel.data!.user!.sId!;

        // Save tokens
        await setUserToken(token, refreshToken, userId);

        // ✅ Fetch latest profile immediately
        await getSingleUser(userId);

        // ✅ Mark as Google login
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isGoogleLoggedIn', true);

        // ✅ Fetch portfolio
        var portfolioController = Get.find<PortfolioController>();
        await portfolioController.getPortfolio();

        // Navigate to main screen
        Get.offAll(NavScreen());

        _isLoading = false;
        update(); // refresh UI
      }
      else if (response != null && response.statusCode == 202) {
        if (response.body['data']['is_phone_verified'] == 0) {
          // handle phone not verified if needed
        }
      }
      else if (response != null && response.statusCode == 400) {
        Get.offAll(() {}); // redirect to login
      }
      else {
        _isLoading = false;
        ApiChecker.checkApi(response!);
      }
    }
    catch (e) {
      debugPrint("Google login failed: $e");
      _isLoading = false;
      update();
    }
  }




  Future<void> getUserPaymentExpiryDate(String id) async {
    try{

      Response response = await authServiceInterface.getWithPaymentSingleUser(id);

      if(response.statusCode == 200){
        getSingleUserResponseModel = GetSingleUserResponseModel.fromJson(response.body);
        print('Single User Payment Status: ${getSingleUserResponseModel!.payment}');
      }else{

      }

    }catch(e){
      print(e.toString());
    }
  }




}
