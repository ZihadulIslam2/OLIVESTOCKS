import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  final String? email;
  final String? otp;

  const CreateNewPasswordScreen({super.key, this.email, this.otp});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _inprogress = false;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  double _passwordStrength = 0;
  String _passwordStrengthLabel = '';

  void _checkPasswordStrength(String password) {
    double strength = 0;
    if (password.length >= 6) strength += 0.25;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength += 0.25;
    if (RegExp(r'[0-9]').hasMatch(password)) strength += 0.25;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) strength += 0.25;

    String label;
    if (strength == 1) {
      label = 'Strong password';
    } else if (strength >= 0.75) {
      label = 'Good password';
    } else if (strength >= 0.5) {
      label = 'Medium strength';
    } else if (strength > 0) {
      label = 'Weak password';
    } else {
      label = '';
    }

    setState(() {
      _passwordStrength = strength;
      _passwordStrengthLabel = label;
    });
  }

  bool get _isFormValid =>
      _passwordStrength == 1 &&
          _confirmPasswordController.text == _newPasswordController.text &&
          _newPasswordController.text.isNotEmpty;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<AuthController>(
            builder: (authController) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: size.width,
                  height: size.height,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Form(
                      key: _formkey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 40),
                            Center(
                              child: Image.asset(
                                'assets/images/olv_logo.png',
                                height: 200,
                                width: 200,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Create new password',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // New Password Field
                            TextFormField(
                              controller: _newPasswordController,
                              obscureText: _obscureNewPassword,
                              decoration: InputDecoration(
                                hintText: 'New Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureNewPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureNewPassword = !_obscureNewPassword;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: const BorderSide(
                                    color: Color(0xff737373),
                                    width: 1,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                _checkPasswordStrength(value);
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter password';
                                }
                                if (_passwordStrength < 1) {
                                  return 'Password is not strong enough';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 8),

                            // Password Strength Bar and Label
                            if (_passwordStrengthLabel.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LinearProgressIndicator(
                                    value: _passwordStrength,
                                    backgroundColor: Colors.grey[300],
                                    color: _passwordStrength == 1
                                        ? Colors.green
                                        : _passwordStrength >= 0.75
                                        ? Colors.lightGreen
                                        : _passwordStrength >= 0.5
                                        ? Colors.orange
                                        : Colors.red,
                                    minHeight: 6,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _passwordStrengthLabel,
                                    style: TextStyle(
                                      color: _passwordStrength == 1
                                          ? Colors.green
                                          : _passwordStrength >= 0.75
                                          ? Colors.lightGreen[700]
                                          : _passwordStrength >= 0.5
                                          ? Colors.orange
                                          : Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),

                            const SizedBox(height: 16),

                            // Confirm Password Field
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: _obscureConfirmPassword,
                              decoration: InputDecoration(
                                hintText: 'Repeat New Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureConfirmPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: const BorderSide(
                                    color: Color(0xff737373),
                                    width: 1,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Confirm your password';
                                }
                                if (value != _newPasswordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 24),

                            Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(51),
                                  backgroundColor: _isFormValid
                                      ? const Color(0xff28A745)
                                      : Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                onPressed: _isFormValid
                                    ? () {
                                  if (_formkey.currentState!.validate()) {
                                    authController.resetPassword(
                                      widget.otp!,
                                      widget.email!,
                                      _newPasswordController.text,
                                    );
                                  }
                                }
                                    : null,
                                child: _inprogress
                                    ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                    : const Text(
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
              );
            }),
      ),
    );
  }
}
