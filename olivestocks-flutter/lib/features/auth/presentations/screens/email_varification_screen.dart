
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../helpers/custom_snackbar.dart';
import '../../controllers/auth_controller.dart';
import 'create_new_password_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String? otp;

  const EmailVerificationScreen({super.key, this.otp});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();



  late TextEditingController otpController;

  bool _inprogress = false;
  bool _isCountingDown = false;
  int _countdownTime = 60;

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();

    print(widget.otp);
    // Start timer automatically if needed
    // _startCountdown();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _startCountdown() {
    setState(() {
      _isCountingDown = true;
      _countdownTime = 60;
    });

    // Update every second
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        _updateCountdown();
      }
    });
  }

  void _updateCountdown() {
    setState(() {
      if (_countdownTime > 0) {
        _countdownTime--;
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            _updateCountdown();
          }
        });
      } else {
        _isCountingDown = false;
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            width: size.width,
            height: size.height,
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Center(
              child: Form(
                key: _formkey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/images/olv_logo.png',
                          height: 200,
                          width: 200,
                        ),
                      ),
                      Text(
                        'Enter security code',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Please check your Email verification. Your code is 6 numbers long.",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff737373),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          PinCodeTextField(
                            length: 6,
                            controller: otpController,
                            obscureText: false,
                            animationType: AnimationType.fade,
                            keyboardType: TextInputType.number,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeFillColor: Colors.white,
                              inactiveFillColor: Colors.white,
                              selectedFillColor: Colors.white,
                            ),
                            animationDuration: const Duration(milliseconds: 300),
                            backgroundColor: Colors.transparent,
                            enableActiveFill: true,
                            appContext: context,
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                      _buildResendCodeButton(),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(51),
                            backgroundColor: const Color(0xff28A745),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              String otp = otpController.text.trim();

                              if (otp.isEmpty || otp.length != 6) {
                                showCustomSnackBar('Please enter a valid 6-digit OTP');
                                return;
                              }

                              print("${widget.otp!} mail $otp  otp");
                              // ✅ Call controller for verification
                              Get.find<AuthController>().emailVerification(widget.otp!, otp);
                            }
                          },
                          child: const Text(
                            'Verify',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOTPForm(context) {
    return Column(
      children: [
        PinCodeTextField(
          length: 6,
          obscureText: false,
          animationType: AnimationType.fade,
          keyboardType: TextInputType.number,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            activeFillColor: Colors.white,
            inactiveFillColor: Colors.white,
            selectedFillColor: Colors.white,
          ),
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          enableActiveFill: true,
          appContext: context,
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildResendCodeButton() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        child: _isCountingDown
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Resend code in ',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text('$_countdownTime',style: TextStyle(color: Color(0xff00BA0B),fontSize: 16),),
            Text('s',style: TextStyle(color: Colors.grey,fontSize: 16),)
          ],
        )
            : TextButton(
          onPressed: () {
            _startCountdown();
            // Add your resend code logic here
          },
          child: const Text(
            'Resend Code',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff00BA0B),
            ),
          ),
        ),
      ),
    );
  }
}