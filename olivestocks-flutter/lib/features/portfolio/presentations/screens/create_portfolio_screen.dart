import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:olive_stocks_flutter/features/auth/controllers/auth_controller.dart';
import 'package:olive_stocks_flutter/features/portfolio/controller/portfolio_controller.dart';

import '../../../../helpers/custom_snackbar.dart';

void showCreatePortfolioDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.all(16),
        child: _CreatePortfolioDialogContent(),
      );
    },
  );
}

class _CreatePortfolioDialogContent extends StatefulWidget {
  const _CreatePortfolioDialogContent({super.key});

  @override
  State<_CreatePortfolioDialogContent> createState() => _CreatePortfolioDialogContentState();
}

class _CreatePortfolioDialogContentState extends State<_CreatePortfolioDialogContent> {
  final TextEditingController _stockNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final portfolioController = Get.find<PortfolioController>();
    final authController = Get.find<AuthController>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Create Portfolio', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextFormField(
                controller: _stockNameController,
                decoration: InputDecoration(
                  hintText: 'Stock Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Color(0xff737373), width: 1),
                  ),
                ),
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter Stock Name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 36),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(51),
                    backgroundColor: const Color(0xff28A745),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: _isLoading ? null : () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      if (authController.isLoggedIn()) {
                        setState(() => _isLoading = true);
                        try {
                          await portfolioController.createNewPortfolio(_stockNameController.text);
                          if (mounted) Navigator.of(context).pop();
                        } finally {
                          if (mounted) setState(() => _isLoading = false);
                        }
                      } else {
                        showCustomSnackBar('!!!You have to login first to create a portfolio.');
                      }
                    }
                  },
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : const Text(
                    'Create',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _stockNameController.dispose();
    super.dispose();
  }
}