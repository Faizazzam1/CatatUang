import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/financial_service.dart';

class AddExpenseController extends GetxController {
  final FinancialService _financialService = Get.find<FinancialService>();

  final amountController = TextEditingController();
  final notesController = TextEditingController();

  final selectedCategory = 'Food & Drinks'.obs;
  final categories = [
    'Food & Drinks',
    'Transport',
    'Shopping',
    'Bills',
    'Health',
    'Fun',
    'Learning',
    'Others'
  ];

  final selectedDate = DateTime.now().obs;
  final selectedPaymentMethod = 'Cash'.obs;
  final paymentMethods = ['Cash', 'E-Wallet', 'Card'];

  void selectCategory(String cat) {
    selectedCategory.value = cat;
  }

  void setDate(DateTime date) {
    selectedDate.value = date;
  }

  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  void saveExpense() {
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

    _financialService.addExpense(
      amount: amount,
      title: notesController.text.trim().isEmpty 
          ? '${selectedCategory.value} Expense' 
          : notesController.text.trim(),
      category: selectedCategory.value,
      date: selectedDate.value,
      paymentMethod: selectedPaymentMethod.value,
      notes: notesController.text.trim(),
    );

    Get.back(); // Return to dashboard
    Get.snackbar(
      'Expense Saved',
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
