import 'package:get/get.dart';
import '../models/transaction_model.dart';

class FinancialService extends GetxService {
  final totalBalance = 14250000.0.obs; // Updated to match initial transactions
  final growthPercentage = 12.5.obs;   // +12.5%
  final incomeAmount = 18500000.0.obs;
  final expenseAmount = 4250000.0.obs;

  final transactions = <TransactionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
  }

  void _loadInitialData() {
    final now = DateTime.now();
    transactions.assignAll([
      // Current transactions (Today/Yesterday)
      TransactionModel(
        id: '1',
        title: 'Artisan Bakery',
        category: 'Food & Drinks',
        amount: 43000.0,
        date: now.subtract(const Duration(hours: 2)),
        isIncome: false,
      ),
      TransactionModel(
        id: '2',
        title: 'City Transport',
        category: 'Transport',
        amount: 30000.0,
        date: now.subtract(const Duration(hours: 4)),
        isIncome: false,
      ),
      TransactionModel(
        id: '3',
        title: 'Freelance Design',
        category: 'Freelance',
        amount: 3500000.0,
        date: now.subtract(const Duration(days: 1, hours: 2)),
        isIncome: true,
      ),
      TransactionModel(
        id: '4',
        title: 'Whole Foods Market',
        category: 'Food & Drinks',
        amount: 84200.0,
        date: now.subtract(const Duration(days: 1, hours: 5)),
        isIncome: false,
      ),
      TransactionModel(
        id: '5',
        title: 'Utility Corp',
        category: 'Bills',
        amount: 72250.0,
        date: now.subtract(const Duration(days: 1, hours: 8)),
        isIncome: false,
      ),
      TransactionModel(
        id: '6',
        title: 'Monthly Salary',
        category: 'Salary',
        amount: 9000000.0,
        date: now.subtract(const Duration(days: 5)),
        isIncome: true,
      ),

      // October 2023 transactions to match Reports screenshot (Rp 4.250.000 total spending)
      TransactionModel(
        id: 'oct_1',
        title: 'Gourmet Dinner',
        category: 'Food & Drinks',
        amount: 1700000.0,
        date: DateTime(2023, 10, 15, 19, 30),
        isIncome: false,
      ),
      TransactionModel(
        id: 'oct_2',
        title: 'Apartment Rent',
        category: 'Rent',
        amount: 1275000.0,
        date: DateTime(2023, 10, 1, 10, 0),
        isIncome: false,
      ),
      TransactionModel(
        id: 'oct_3',
        title: 'Train Pass & Taxi',
        category: 'Transport',
        amount: 637500.0,
        date: DateTime(2023, 10, 10, 8, 30),
        isIncome: false,
      ),
      TransactionModel(
        id: 'oct_4',
        title: 'Movie Night & Concert',
        category: 'Entertainment',
        amount: 637500.0,
        date: DateTime(2023, 10, 22, 21, 0),
        isIncome: false,
      ),
      TransactionModel(
        id: 'oct_5',
        title: 'Freelance Project Income',
        category: 'Freelance',
        amount: 6000000.0,
        date: DateTime(2023, 10, 25, 14, 0),
        isIncome: true,
      ),
    ]);
  }

  void addIncome({
    required double amount,
    required String title,
    required String category,
    required DateTime date,
    required String depositTo,
    required String notes,
  }) {
    final newTx = TransactionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      category: category,
      amount: amount,
      date: date,
      isIncome: true,
    );
    transactions.insert(0, newTx);
    totalBalance.value += amount;
    incomeAmount.value += amount;
  }

  void addExpense({
    required double amount,
    required String title,
    required String category,
    required DateTime date,
    required String paymentMethod,
    required String notes,
  }) {
    final newTx = TransactionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      category: category,
      amount: amount,
      date: date,
      isIncome: false,
    );
    transactions.insert(0, newTx);
    totalBalance.value -= amount;
    expenseAmount.value += amount;
  }
}
