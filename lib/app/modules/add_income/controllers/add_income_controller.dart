import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/financial_service.dart';

class AddIncomeController extends GetxController {
  final FinancialService _financialService = Get.find<FinancialService>();

  final amountController = TextEditingController();
  final notesController = TextEditingController();

  final selectedCategory = 'Salary'.obs;
  final categories = ['Salary', 'Freelance', 'Gift'].obs;

  final selectedDate = DateTime.now().obs;
  final depositTo = 'Main Savings'.obs;
  final depositAccounts = ['Main Savings', 'Digital Wallet', 'Investment Account'];

  void selectCategory(String cat) {
    selectedCategory.value = cat;
  }

  void setDate(DateTime date) {
    selectedDate.value = date;
  }

  void setDepositTo(String value) {
    depositTo.value = value;
  }

  void saveIncome() {
    final amountText = amountController.text.replaceAll(RegExp(r'[^0-9]'), '');
    final amount = double.tryParse(amountText) ?? 0.0;

    if (amount <= 0) {
      Get.snackbar(
        'Invalid Amount',
        'Please enter a valid amount greater than 0',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
      );
      return;
    }

    // Call service to save income
    _financialService.addIncome(
      amount: amount,
      title: notesController.text.trim().isEmpty 
          ? '${selectedCategory.value} Income' 
          : notesController.text.trim(),
      category: selectedCategory.value,
      date: selectedDate.value,
      depositTo: depositTo.value,
      notes: notesController.text.trim(),
    );

    Get.back(); // Return to dashboard
    Get.snackbar(
      'Income Saved',
      'Transaction added successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF10B981),
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {
    amountController.dispose();
    notesController.dispose();
    super.onClose();
  }
}
