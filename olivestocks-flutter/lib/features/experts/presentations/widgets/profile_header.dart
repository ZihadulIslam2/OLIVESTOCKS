import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../common/widgets/cutom_profile_image.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../../../portfolio/controller/portfolio_controller.dart';
import '../screens/edit_user_profile_screen.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({super.key});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initUser();
    });
  }

  Future<void> _initUser() async {
    String id = await getUserId();
    if (id.isNotEmpty) {
      // Load user data once
      await Get.find<AuthController>().getSingleUser(id);
    }
    setState(() {
      _loading = false;
    });
  }

  SharedPreferences? sharedPreferences;

  Future<String> getUserId() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences!.getString('userId') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) {
        return GetBuilder<PortfolioController>(
          builder: (portfolioController) {
            var userData = authController.getSingleUserResponseModel?.data;

            if (_loading) {
              // Show loading avatar with loader ring, no other UI yet
              return Row(
                children: const [
                  ProfileAvatarWithBadge(isLoading: true),
                  SizedBox(width: 10),
                  Text('Loading user...', style: TextStyle(fontSize: 16)),
                ],
              );
            }

            if (userData == null || userData.sId == null) {
              // Data not loaded or invalid
              return Center(child: Text('No user data found'));
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ProfileAvatarWithBadge(isLoading: false),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userData.fullName ?? userData.userName ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            userData.email ?? '',
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            userData.role ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            userData.phoneNumber ?? '',
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            userData.followers?.toString() ?? '',
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            userData.address ?? '',
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          final user = userData;
                          Get.to(() => EditUserProfileScreen(
                            userName: user.fullName ?? user.userName ?? '',
                            email: user.email ?? '',
                            phoneNumber: user.phoneNumber ?? '',
                            address: user.address ?? '',
                            profilePhoto: user.profilePhoto ?? '',
                            userId: user.sId ?? '',
                          ));
                        },
                        icon: const Icon(Icons.edit_calendar,color: Colors.green,),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
