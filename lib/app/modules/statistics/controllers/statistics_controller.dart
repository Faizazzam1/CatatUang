import 'package:get/get.dart';

class SavingGoal {
  final String title;
  final double target;
  final double current;
  final String category;
  final DateTime dueDate;

  SavingGoal({
    required this.title,
    required this.target,
    required this.current,
    required this.category,
    required this.dueDate,
  });

  double get progress => (current / target).clamp(0.0, 1.0);
}

class StatisticsController extends GetxController {
  final activeGoals = <SavingGoal>[].obs;

  // Computed total progress across all goals
  double get totalSaved =>
      activeGoals.fold(0.0, (sum, g) => sum + g.current);

  double get totalTarget =>
      activeGoals.fold(0.0, (sum, g) => sum + g.target);

  double get overallProgress =>
      totalTarget > 0 ? (totalSaved / totalTarget).clamp(0.0, 1.0) : 0.0;

  @override
  void onInit() {
    super.onInit();
    _loadMockGoals();
  }

  void _loadMockGoals() {
    activeGoals.assignAll([
      SavingGoal(
        title: 'New Laptop',
        target: 15000000.0,
        current: 10500000.0,
        category: 'Tech',
        dueDate: DateTime(2026, 9, 1),
      ),
      SavingGoal(
        title: 'Vacation',
        target: 8000000.0,
        current: 2400000.0,
        category: 'Travel',
        dueDate: DateTime(2026, 12, 25),
      ),
      SavingGoal(
        title: 'Emergency Fund',
        target: 20000000.0,
        current: 11000000.0,
        category: 'Safety',
        dueDate: DateTime(2027, 3, 1),
      ),
    ]);
  }
}
