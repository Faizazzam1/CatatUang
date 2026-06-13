import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../profile/controllers/profile_controller.dart';

class EditProfileController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _loadCurrentProfile();
  }

  void _loadCurrentProfile() {
    try {
      final profileCtrl = Get.find<ProfileController>();
      nameController.text = profileCtrl.name.value;
      emailController.text = profileCtrl.email.value;
    } catch (_) {
      nameController.text = 'Alex Rivers';
      emailController.text = 'alex.rivers@fintech-email.com';
    }
  }

  void saveProfile() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Name and email fields cannot be empty.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
      );
      return;
    }

    try {
      final profileCtrl = Get.find<ProfileController>();
      profileCtrl.name.value = name;
      profileCtrl.email.value = email;
    } catch (_) {}

    Get.back();
    Get.snackbar(
      'Profile Updated',
      'Your profile changes have been saved.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF10B981),
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
