import 'package:get/get.dart';
import '../../../data/services/financial_service.dart';

class DashboardController extends GetxController {
  final FinancialService financialService = Get.find<FinancialService>();

  // Navigation Index (0 = Dashboard)
  final currentNavIndex = 0.obs;

  void changeNavIndex(int index) {
    currentNavIndex.value = index;
  }
}
