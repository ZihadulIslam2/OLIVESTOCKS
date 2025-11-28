import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/portfolio/controller/portfolio_controller.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  String? selectedOption; // For the dropdown menu

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _massageController;

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _massageController = TextEditingController();
    selectedOption = "General Inquiry";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4.0,
        shadowColor: Colors.black,
        title: const Text(
          'Contact Us',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_backspace, color: Colors.black),
        ),
      ),
      body: GetBuilder<PortfolioController>(builder: (portfolioController){
        return portfolioController.isSupportLoading ? const Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.05), // Dynamic padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'We are always happy to help. Please be in touch with any questions or suggestions, and we will get back to you via email as soon as we can.',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: screenWidth * 0.05), // Dynamic spacing
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffE6E6E6),
                    hintText: 'Select a topic',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  value: selectedOption,
                  items: <String>['General Inquiry', 'Feedback', 'Support', 'Others']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedOption = newValue;
                    });
                  },
                ),
                SizedBox(height: screenWidth * 0.04), // Dynamic spacing
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffE6E6E6), // Gray background
                    hintText: 'First Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: screenWidth * 0.04),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffE6E6E6), // Gray background
                    hintText: 'Last Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: screenWidth * 0.04),// Dynamic spacing
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffE6E6E6), // Gray background
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: screenWidth * 0.04),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffE6E6E6), // Gray background
                    hintText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: screenWidth * 0.04),// Dynamic spacing
                TextFormField(
                  controller: _massageController,
                  maxLines: 4, // For multi-line input
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffE6E6E6), // Gray background
                    hintText: 'Message',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: screenWidth * 0.06), // Dynamic spacing
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      String firstName = _firstNameController.text;
                      String lastName = _lastNameController.text;
                      String email = _emailController.text;
                      String phoneNumber = _phoneNumberController.text;
                      String message = _massageController.text;
                    if(firstName.isEmpty){
                      Get.snackbar("Error", "Please enter your first name");
                    }else if(lastName.isEmpty){
                      Get.snackbar("Error", "Please enter your last name");
                    }else if(email.isEmpty){
                      Get.snackbar("Error", "Please enter your email");
                    }else if(phoneNumber.isEmpty){
                      Get.snackbar("Error", "Please enter your phone number");
                    }else if(message.isEmpty){
                      Get.snackbar("Error", "Please enter your message");
                    }else{
                      portfolioController.postSupport(firstName, lastName, email, message,selectedOption!, phoneNumber);
                    }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff28A745),
                      minimumSize: Size(screenWidth * 0.5, 48), // Dynamic button size
                    ),
                    child: const Text('SEND', style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
