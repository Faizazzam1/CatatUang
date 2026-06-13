import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final name = 'Alex Rivers'.obs;
  final email = 'alex.rivers@fintech-email.com'.obs;
  final isPremium = true.obs;
  final monthlySavings = 18500000.0.obs;
  final activeGoalsCount = 4.obs;

  void logout() {
    Get.snackbar(
      'Logged Out',
      'Your session has been successfully cleared.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1E293B),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
    // Redirect to login page
    Get.offAllNamed(Routes.LOGIN);
  }
}
