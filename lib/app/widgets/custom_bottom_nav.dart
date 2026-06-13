import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWide = screenWidth > 600;

    return SafeArea(
      child: Container(
        height: isWide ? 112 : 80, // Restricts height so it doesn't take up the whole screen
        padding: EdgeInsets.symmetric(
          horizontal: isWide ? 24 : 0,
          vertical: isWide ? 16 : 0,
        ),
        alignment: Alignment.center,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: isWide ? 600 : double.infinity,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: isWide ? BorderRadius.circular(24) : BorderRadius.zero,
            border: isWide ? Border.all(color: const Color(0xFFF1F5F9)) : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(isWide ? 12 : 6),
                blurRadius: isWide ? 16 : 10,
                offset: Offset(0, isWide ? 4 : -2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: isWide ? BorderRadius.circular(24) : BorderRadius.zero,
            child: NavigationBar(
              selectedIndex: currentIndex,
              onDestinationSelected: (index) {
                if (index == currentIndex) return;
                switch (index) {
                  case 0:
                    Get.offAllNamed(Routes.DASHBOARD);
                    break;
                  case 1:
                    Get.offAllNamed(Routes.TRANSACTIONS);
                    break;
                  case 2:
                    Get.offAllNamed(Routes.STATS);
                    break;
                  case 3:
                    Get.offAllNamed(Routes.REPORTS);
                    break;
                  case 4:
                    Get.offAllNamed(Routes.PROFILE);
                    break;
                }
              },
              backgroundColor: Colors.white,
              elevation: 0,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard_rounded, color: Color(0xFF2563EB)),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.receipt_long_outlined),
                  selectedIcon: Icon(Icons.receipt_long_rounded, color: Color(0xFF2563EB)),
                  label: 'Transactions',
                ),
                NavigationDestination(
                  icon: Icon(Icons.bar_chart_outlined),
                  selectedIcon: Icon(Icons.bar_chart_rounded, color: Color(0xFF2563EB)),
                  label: 'Goals',
                ),
                NavigationDestination(
                  icon: Icon(Icons.description_outlined),
                  selectedIcon: Icon(Icons.description_rounded, color: Color(0xFF2563EB)),
                  label: 'Reports',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline_rounded),
                  selectedIcon: Icon(Icons.person_rounded, color: Color(0xFF2563EB)),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
