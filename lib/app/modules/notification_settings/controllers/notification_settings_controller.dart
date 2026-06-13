import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationSettingsController extends GetxController {
  final dailyReminders = true.obs;
  final billDueDates = true.obs;
  final budgetAlerts = true.obs;
  final savingsMilestones = false.obs;

  final preferredTime = '08:00 AM'.obs;
  final preferredTimes = ['08:00 AM', '12:00 PM', '06:00 PM'];

  final customTimeController = TextEditingController(text: '08:00');

  void toggleDailyReminders(bool value) => dailyReminders.value = value;
  void toggleBillDueDates(bool value) => billDueDates.value = value;
  void toggleBudgetAlerts(bool value) => budgetAlerts.value = value;
  void toggleSavingsMilestones(bool value) => savingsMilestones.value = value;

  void selectPreferredTime(String time) {
    preferredTime.value = time;
  }

  void saveSettings() {
    // Save settings logic here (could write to local storage / DB)
    Get.back(); // Navigate back to Dashboard
    Get.snackbar(
      'Settings Saved',
      'Notification settings updated successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF10B981),
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {
    customTimeController.dispose();
    super.onClose();
  }
}
