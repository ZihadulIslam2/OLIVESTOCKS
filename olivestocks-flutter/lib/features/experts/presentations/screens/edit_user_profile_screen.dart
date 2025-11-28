import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../auth/controllers/auth_controller.dart';

class EditUserProfileScreen extends StatefulWidget {
  final String userName;
  final String email;
  final String phoneNumber;
  final String address;
  final String profilePhoto;
  final String userId;

  const EditUserProfileScreen({
    super.key,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.profilePhoto,
    required this.userId,
  });

  @override
  State<EditUserProfileScreen> createState() => _EditUserProfileScreenState();
}

class _EditUserProfileScreenState extends State<EditUserProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _addressCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.userName);
    _emailCtrl = TextEditingController(text: widget.email);
    _phoneCtrl = TextEditingController(text: widget.phoneNumber);
    _addressCtrl = TextEditingController(text: widget.address);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      final pickedFile = authController.pickedProfileFile;

      return Scaffold(
        appBar: AppBar(title: const Text("Edit Profile")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () => authController.pickImage(false, true),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: pickedFile != null
                              ? FileImage(File(pickedFile.path))
                              : NetworkImage(widget.profilePhoto) as ImageProvider,
                        ),
                        const SizedBox(height: 8),
                        const Text("Tap to change profile photo"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameCtrl,
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) => val!.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) => val!.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _phoneCtrl,
                  decoration: const InputDecoration(
                    labelText: "Phone",
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) => val!.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _addressCtrl,
                  decoration: const InputDecoration(
                    labelText: "Address",
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) => val!.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 24),
                Obx(() {
                  final isLoading = authController.isUpdateProfileLoading.value;
                  return ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await authController.postUpdateProfile(
                          _nameCtrl.text,
                          _emailCtrl.text,
                          _phoneCtrl.text,
                          _addressCtrl.text,
                          pickedFile?.path,
                          widget.userId,
                        );

                        await Get.find<AuthController>().getSingleUser(widget.userId);
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Save Changes", style: TextStyle(fontSize: 16,color: Colors.white)),
                  );
                }),
              ],
            ),
          ),
        ),
      );
    });
  }
}
