import 'package:get/get.dart';
import '../../../data/services/financial_service.dart';
import '../../../data/models/transaction_model.dart';

class TransactionsController extends GetxController {
  final FinancialService financialService = Get.find<FinancialService>();

  final searchQuery = ''.obs;
  final selectedFilter = 'All'.obs; // 'All', 'Income', 'Expense', 'Transport', 'Bills'

  List<TransactionModel> get filteredTransactions {
    return financialService.transactions.where((tx) {
      // Search filter
      final matchesSearch =
          tx.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
              tx.category.toLowerCase().contains(searchQuery.value.toLowerCase());

      // Type / category filter
      switch (selectedFilter.value) {
        case 'Income':
          return matchesSearch && tx.isIncome;
        case 'Expense':
          return matchesSearch && !tx.isIncome;
        case 'Transport':
          return matchesSearch &&
              tx.category.toLowerCase() == 'transport';
        case 'Bills':
          return matchesSearch &&
              tx.category.toLowerCase() == 'bills';
        default:
          return matchesSearch;
      }
    }).toList();
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }
}
