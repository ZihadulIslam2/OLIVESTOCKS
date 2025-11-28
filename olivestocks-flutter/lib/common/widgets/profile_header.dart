import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/controllers/auth_controller.dart';
import '../../features/auth/presentations/screens/login_screen.dart';
import '../../features/experts/presentations/screens/user_profile_screen.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  SharedPreferences? sharedPreferences;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authController = Get.find<AuthController>();
      if (authController.getSingleUserResponseModel?.data?.sId == null) {
        _initUser();
      }
    });
  }

  Future<void> _initUser() async {
    String id = await getUserId();
    if (id.isNotEmpty) {
      await Get.find<AuthController>().getSingleUser(id);
    }
  }

  Future<String> getUserId() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences?.getString('userId') ?? '';
  }

  Future<bool> _isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final isGoogleLoggedIn = prefs.getBool('isGoogleLoggedIn') ?? false;
    final isUserLoggedIn = Get.find<AuthController>().isLoggedIn();
    return isUserLoggedIn || isGoogleLoggedIn;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<AuthController>(builder: (authController) {
      final isLoading = authController.isSingleUserLoading;
      final userData = authController.getSingleUserResponseModel?.data;
      final subscriptionStatus =
          authController.getSingleUserResponseModel?.payment ?? "Free";

      return FutureBuilder<bool>(
        future: _isLoggedIn(),
        builder: (context, snapshot) {
          final isLoggedIn = snapshot.data ?? false;

          // 🔒 Guest User (not logged in)
          if (!isLoggedIn || userData == null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    CircleAvatar(
                      radius: 26,
                      backgroundImage:
                      AssetImage('assets/logos/man_avater.png'),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Guest User",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  "Please login to view your profile",
                  style: TextStyle(fontSize: 14, color: Color(0xFF595959)),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: size.height * .035,
                  width: size.width * .29,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Get.offAll(() => const LoginScreen());
                    },
                    icon: const Icon(Icons.login,
                        size: 16, color: Colors.white),
                    label: const Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      side: const BorderSide(color: Colors.white),
                    ),
                  ),
                )
              ],
            );
          }

          // ✅ Logged in user
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const UserProfileScreen());
                    },
                    child: CircleAvatar(
                      radius: 26,
                      backgroundImage: userData.profilePhoto != null &&
                          userData.profilePhoto!.isNotEmpty
                          ? NetworkImage(userData.profilePhoto!)
                          : const AssetImage(
                          'assets/images/default_avatar.png')
                      as ImageProvider,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    height: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: subscriptionStatus.toLowerCase() == 'premium'
                          ? Colors.blue
                          : subscriptionStatus.toLowerCase() == 'ultimate'
                          ? Colors.green
                          : Colors.orange,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      subscriptionStatus,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  Get.to(() => const UserProfileScreen());
                },
                child: Text(
                  userData.userName ?? "Username",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                userData.email ?? "",
                style: const TextStyle(fontSize: 14, color: Color(0xFF595959)),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: size.height * .035,
                width: size.width * .29,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    if (isLoggedIn) {
                      authController.logOut();
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('isGoogleLoggedIn', false);
                      authController.logOut();
                    } else {
                      Get.offAll(() => const LoginScreen());
                    }
                  },
                  icon: isLoggedIn
                      ? const Icon(Icons.logout,
                      size: 16, color: Colors.white)
                      : const Icon(Icons.login,
                      size: 16, color: Colors.white),
                  label: Text(
                    isLoggedIn ? 'Sign out' : 'Login',
                    style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor:
                    isLoggedIn ? Colors.redAccent : Colors.greenAccent,
                    side: const BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          );
        },
      );
    });
  }
}
