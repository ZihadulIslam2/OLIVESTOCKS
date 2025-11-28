import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/features/when_click_on_skip/presentation/screen/when_click_on_skip_screen.dart';

import '../../../tearms_and _conditions/terms_and_conditions_screen.dart';
import '../../controllers/auth_controller.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _phoneController;
  late TextEditingController _nameController;

  double _passwordStrength = 0;
  String _passwordStrengthLabel = '';
  bool _isPasswordStrong = false;
  bool _termsAccepted = false;
  bool _inprogress = false;

  @override
  initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _phoneController = TextEditingController();
    _nameController = TextEditingController();
  }

  void _checkPasswordStrength(String password) {
    double strength = 0;
    if (password.length >= 6) strength += 0.25;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength += 0.25;
    if (RegExp(r'[0-9]').hasMatch(password)) strength += 0.25;
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) strength += 0.25;

    setState(() {
      _passwordStrength = strength;
      if (strength < 0.5) {
        _passwordStrengthLabel = 'Weak';
        _isPasswordStrong = false;
      } else if (strength < 0.75) {
        _passwordStrengthLabel = 'Medium';
        _isPasswordStrong = false;
      } else {
        _passwordStrengthLabel = 'Strong';
        _isPasswordStrong = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: GetBuilder<AuthController>(builder: (authController) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/olv_logo.png',
                            height: 150,
                            width: 200,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () async {
                                    await authController.googleSignIn();
                                  },
                                  child: Image.asset('assets/logos/google.png', height: 50, width: 50)),
                              const SizedBox(width: 20),
                              Image.asset('assets/logos/microsoft.png', height: 50, width: 50),
                              const SizedBox(width: 20),
                              Image.asset('assets/logos/apple_login.png', height: 50, width: 50),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff000000),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildInputField(_nameController, 'Username'),
                    const SizedBox(height: 16),
                    _buildInputField(_emailController, 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                        value!.isEmpty ? 'Enter valid email' : null),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      onChanged: _checkPasswordStrength,
                      decoration: _inputDecoration('Password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a valid password';
                        }
                        if (!_isPasswordStrong) {
                          return 'Include uppercase, number & special character';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: _passwordStrength,
                      backgroundColor: Colors.grey[300],
                      color: _passwordStrength >= 0.75
                          ? Colors.green
                          : _passwordStrength >= 0.5
                          ? Colors.orange
                          : Colors.red,
                    ),
                    Text(
                      'Strength: $_passwordStrengthLabel',
                      style: TextStyle(
                        color: _passwordStrength >= 0.75
                            ? Colors.green
                            : _passwordStrength >= 0.5
                            ? Colors.orange
                            : Colors.red,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: _inputDecoration('Confirm password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(
                          value: _termsAccepted,
                          onChanged: (value) =>
                              setState(() => _termsAccepted = value ?? false),
                        ),
                        Row(
                          children: [
                            Text('I agree to the '),
                            GestureDetector(
                              onTap: () => Get.to(TermsAndConditionsScreen()),
                                child: Text('Terms and Conditions ',style: TextStyle(color: Colors.blue),)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 51,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isPasswordStrong && _termsAccepted
                              ? const Color(0xff00BA0B)
                              : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: _isPasswordStrong && _termsAccepted
                            ? () {
                          if (_formkey.currentState!.validate()) {
                            authController.register(
                              _nameController.text,
                              _emailController.text,
                              _phoneController.text,
                              _passwordController.text,
                              _confirmPasswordController.text,
                            );
                          }
                        }
                            : null,
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () => Get.to(LoginScreen()),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                color: Color(0xff00BA0B),
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () => Get.to(WhenClickOnSkip()),
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            color: Color(0xff00BA0B),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xff737373), width: 1),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hint,
      {TextInputType? keyboardType, String? Function(String?)? validator}) {
    return SizedBox(
      height: 51,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: _inputDecoration(hint),
      ),
    );
  }
}
