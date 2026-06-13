import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/statistics_controller.dart';
import '../../../widgets/custom_bottom_nav.dart';

class StatisticsView extends GetView<StatisticsController> {
  const StatisticsView({super.key});

  // ── Helpers ──────────────────────────────────────────────────────────────

  String _formatRupiah(double amount) {
    final amountStr = amount.toStringAsFixed(0);
    var formatted = '';
    var count = 0;
    for (var i = amountStr.length - 1; i >= 0; i--) {
      if (count % 3 == 0 && count != 0) formatted = '.$formatted';
      formatted = amountStr[i] + formatted;
      count++;
    }
    return 'Rp $formatted';
  }

  String _formatDueDate(DateTime date) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[date.month]} ${date.day}, ${date.year}';
  }

  Color _goalColor(int index) {
    const colors = [
      Color(0xFF2563EB),
      Color(0xFF7C3AED),
      Color(0xFF10B981),
      Color(0xFFF59E0B),
    ];
    return colors[index % colors.length];
  }

  IconData _goalIcon(String category) {
    switch (category.toLowerCase()) {
      case 'tech':
        return Icons.laptop_mac_rounded;
      case 'travel':
        return Icons.flight_takeoff_rounded;
      case 'safety':
        return Icons.shield_rounded;
      case 'finance':
        return Icons.trending_up_rounded;
      default:
        return Icons.star_rounded;
    }
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Savings Goals',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Total Goals Progress Card ────────────────────────────────
              _buildTotalProgressCard(),
              const SizedBox(height: 24),

              // ── Section Header ───────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'ACTIVE GOALS',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    '${controller.activeGoals.length} goals',
                    style: const TextStyle(
                      color: Color(0xFF2563EB),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // ── Goal Cards ───────────────────────────────────────────────
              ...List.generate(controller.activeGoals.length, (index) {
                final goal = controller.activeGoals[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildGoalCard(goal, index),
                );
              }),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => const CreateGoalPage());
        },
        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,
        elevation: 4,
        icon: const Icon(Icons.add, size: 22),
        label: const Text(
          'Add New Goal',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 2),
    );
  }

  // ── Total Progress Card ───────────────────────────────────────────────────

  Widget _buildTotalProgressCard() {
    final saved = controller.totalSaved;
    final target = controller.totalTarget;
    final progress = controller.overallProgress;
    final pct = (progress * 100).toStringAsFixed(1);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2563EB).withAlpha(70),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label + Percentage
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'TOTAL GOAL PROGRESS',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.4,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(35),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$pct%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Total saved amount
          Text(
            _formatRupiah(saved),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: const [
              Icon(Icons.trending_up_rounded,
                  color: Colors.greenAccent, size: 16),
              SizedBox(width: 4),
              Text(
                '+15.5% from last month',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 18),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.white.withAlpha(40),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Saved: ${_formatRupiah(saved)}',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              Text(
                'Target: ${_formatRupiah(target)}',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Individual Goal Card ──────────────────────────────────────────────────

  Widget _buildGoalCard(SavingGoal goal, int index) {
    final color = _goalColor(index);
    final pct = (goal.progress * 100).toStringAsFixed(0);
    final daysLeft = goal.dueDate.difference(DateTime.now()).inDays;

    return GestureDetector(
      onTap: () {
        Get.to(() => GoalDetailPage(goal: goal, color: color));
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFF1F5F9)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(6),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row: icon + title + percentage
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withAlpha(20),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(_goalIcon(goal.category),
                      color: color, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        goal.title,
                        style: const TextStyle(
                          color: Color(0xFF1E293B),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        goal.category,
                        style: const TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                // Percentage badge
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: color.withAlpha(18),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$pct%',
                    style: TextStyle(
                      color: color,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: goal.progress,
                minHeight: 8,
                backgroundColor: const Color(0xFFF1F5F9),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            const SizedBox(height: 12),
            // Saved / Target / Due Date row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Saved',
                      style: TextStyle(
                          color: Color(0xFF94A3B8), fontSize: 11),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _formatRupiah(goal.current),
                      style: TextStyle(
                        color: color,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Target',
                      style: TextStyle(
                          color: Color(0xFF94A3B8), fontSize: 11),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _formatRupiah(goal.target),
                      style: const TextStyle(
                        color: Color(0xFF1E293B),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Due Date',
                      style: TextStyle(
                          color: Color(0xFF94A3B8), fontSize: 11),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          size: 11,
                          color: daysLeft < 90
                              ? const Color(0xFFF59E0B)
                              : const Color(0xFF64748B),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          _formatDueDate(goal.dueDate),
                          style: TextStyle(
                            color: daysLeft < 90
                                ? const Color(0xFFF59E0B)
                                : const Color(0xFF64748B),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── CreateGoalPage (Inline Mock Widget) ───────────────────────────────────

class CreateGoalPage extends StatefulWidget {
  const CreateGoalPage({super.key});

  @override
  State<CreateGoalPage> createState() => _CreateGoalPageState();
}

class _CreateGoalPageState extends State<CreateGoalPage> {
  final _titleController = TextEditingController();
  final _targetController = TextEditingController();
  String _category = 'Tech';
  DateTime _dueDate = DateTime.now().add(const Duration(days: 90));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Create Goal', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Define Your Dream',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 6),
            const Text('Set a clear name, target, and timeline for your savings goal.',
                style: TextStyle(color: Color(0xFF64748B))),
            const SizedBox(height: 28),
            // Title input
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Goal Name',
                hintText: 'e.g. New Laptop',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
            const SizedBox(height: 16),
            // Target input
            TextField(
              controller: _targetController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Target Amount (Rp)',
                hintText: 'e.g. 15000000',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
            const SizedBox(height: 16),
            // Category dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _category,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(value: 'Tech', child: Text('Technology')),
                    DropdownMenuItem(value: 'Travel', child: Text('Travel / Vacation')),
                    DropdownMenuItem(value: 'Safety', child: Text('Emergency / Safety')),
                    DropdownMenuItem(value: 'Finance', child: Text('Finance / Investment')),
                  ],
                  onChanged: (val) {
                    if (val != null) setState(() => _category = val);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Due Date selector
            GestureDetector(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _dueDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 3650)),
                );
                if (date != null) setState(() => _dueDate = date);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Due Date', style: TextStyle(fontSize: 16)),
                    Text('${_dueDate.day}/${_dueDate.month}/${_dueDate.year}',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2563EB))),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 36),
            // Save Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  final title = _titleController.text.trim();
                  final targetVal = double.tryParse(_targetController.text.trim()) ?? 0;
                  if (title.isEmpty || targetVal <= 0) {
                    Get.snackbar('Error', 'Please provide valid goal details');
                    return;
                  }
                  // Add goal to controller
                  final controller = Get.find<StatisticsController>();
                  controller.activeGoals.add(SavingGoal(
                    title: title,
                    target: targetVal,
                    current: 0,
                    category: _category,
                    dueDate: _dueDate,
                  ));
                  Get.back();
                  Get.snackbar('Success', 'Goal created successfully!');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Create Goal', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ── GoalDetailPage (Inline Mock Widget) ───────────────────────────────────

class GoalDetailPage extends StatelessWidget {
  final SavingGoal goal;
  final Color color;

  const GoalDetailPage({super.key, required this.goal, required this.color});

  String _formatRupiah(double amount) {
    final amountStr = amount.toStringAsFixed(0);
    var formatted = '';
    var count = 0;
    for (var i = amountStr.length - 1; i >= 0; i--) {
      if (count % 3 == 0 && count != 0) formatted = '.$formatted';
      formatted = amountStr[i] + formatted;
      count++;
    }
    return 'Rp $formatted';
  }

  @override
  Widget build(BuildContext context) {
    final pct = (goal.progress * 100).toStringAsFixed(1);
    final remaining = (goal.target - goal.current).clamp(0.0, goal.target);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(goal.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero card progress
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.black.withAlpha(5), blurRadius: 10, offset: const Offset(0, 4))
                ],
              ),
              child: Column(
                children: [
                  // Circular Progress Indicator representing goal progress
                  SizedBox(
                    width: 140,
                    height: 140,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: CircularProgressIndicator(
                            value: goal.progress,
                            strokeWidth: 12,
                            backgroundColor: const Color(0xFFF1F5F9),
                            valueColor: AlwaysStoppedAnimation<Color>(color),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '$pct%',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: color),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Saved Amount', style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                          const SizedBox(height: 4),
                          Text(_formatRupiah(goal.current),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('Target Goal', style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                          const SizedBox(height: 4),
                          Text(_formatRupiah(goal.target),
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            // Target Detail Details List
            const Text('GOAL INSIGHTS',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF64748B), letterSpacing: 1.2)),
            const SizedBox(height: 12),
            _buildDetailRow('Category', goal.category),
            _buildDetailRow('Remaining to save', _formatRupiah(remaining)),
            _buildDetailRow('Due Date', '${goal.dueDate.day}/${goal.dueDate.month}/${goal.dueDate.year}'),
            const SizedBox(height: 28),
            // Simulating a deposit action
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  // Prompt to add fund
                  Get.defaultDialog(
                    title: 'Add Fund',
                    content: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Amount (Rp)'),
                      onSubmitted: (val) {
                        final amt = double.tryParse(val) ?? 0;
                        if (amt > 0) {
                          // Mutate goal
                          // Since we keep everything in controllers simple, we can add it:
                          final controller = Get.find<StatisticsController>();
                          final idx = controller.activeGoals.indexOf(goal);
                          if (idx != -1) {
                            final old = controller.activeGoals[idx];
                            controller.activeGoals[idx] = SavingGoal(
                              title: old.title,
                              target: old.target,
                              current: old.current + amt,
                              category: old.category,
                              dueDate: old.dueDate,
                            );
                          }
                          Get.back();
                          Get.back();
                          Get.snackbar('Success', 'Successfully deposited funds!');
                        }
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Add Savings Fund', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
