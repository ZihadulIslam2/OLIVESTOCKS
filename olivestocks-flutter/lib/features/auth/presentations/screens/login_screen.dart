import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:olive_stocks_flutter/features/auth/controllers/auth_controller.dart';
import 'package:olive_stocks_flutter/features/auth/presentations/screens/signup_screen.dart';
import '../../../portfolio/controller/portfolio_controller.dart';
import '../../../when_click_on_skip/presentation/screen/when_click_on_skip_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.email, this.otp});
  final String? email;
  final String? otp;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late TextEditingController otpController;

  bool _inprogress = false;
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
    loadRememberedCredentials();
  }

  Future<void> loadRememberedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('remembered_email');
    final savedPassword = prefs.getString('remembered_password');
    final remember = prefs.getBool('remember_me') ?? false;

    if (remember) {
      setState(() {
        _emailController.text = savedEmail ?? '';
        _passwordController.text = savedPassword ?? '';
        _rememberMe = true;
      });
    }
  }

  Future<void> saveCredentialsIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      await prefs.setString('remembered_email', _emailController.text);
      await prefs.setString('remembered_password', _passwordController.text);
      await prefs.setBool('remember_me', true);
    } else {
      await prefs.remove('remembered_email');
      await prefs.remove('remembered_password');
      await prefs.setBool('remember_me', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<AuthController>(
      builder: (authController) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const SizedBox(height: 100),
                      Center(
                        child: Image.asset(
                          'assets/images/olv_logo.png',
                          height: 104,
                          width: 124,
                        ),
                      ),
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          'or use your Username for login',
                          style: TextStyle(color: Color(0xff2F2F2F), fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('Login', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      const Text('Please sign in to continue', style: TextStyle(fontSize: 16, color: Color(0xff737373))),
                      const SizedBox(height: 20),

                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(color: Color(0xff737373)),
                          ),
                        ),
                        validator: (value) => (value?.isEmpty ?? true) ? 'Enter valid email' : null,
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Enter a valid password';
                          if (value.length < 6) return 'Password must be at least 6 characters';
                          if (!RegExp(r'[A-Z]').hasMatch(value)) return 'Include at least one uppercase letter';
                          if (!RegExp(r'[0-9]').hasMatch(value)) return 'Include at least one number';
                          if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) return 'Include at least one special character';
                          return null;
                        },
                      ),

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = value ?? false;
                                  });
                                },
                              ),
                              const Text('Remember me'),
                            ],
                          ),
                          TextButton(
                            onPressed: () => Get.to(ForgotPasswordScreen()),
                            child: const Text('Forgot Password?', style: TextStyle(color: Color(0xff00BA0B))),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(51),
                          backgroundColor: const Color(0xff28A745),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            final email = _emailController.text;
                            final password = _passwordController.text;

                            await saveCredentialsIfNeeded();

                            authController.login(email, password).then((_) {
                              Get.find<PortfolioController>().setWatchListSelected();
                            });
                          }
                        },
                        child: const Text('Login', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      ),

                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("If you don't have an account?", style: TextStyle(color: Color(0xff737373), fontSize: 16)),
                          TextButton(
                            onPressed: () => Get.to(SignupScreen()),
                            child: const Text('Register', style: TextStyle(color: Color(0xff00BA0B), fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
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
          ),
        );
      },
    );
  }
}
