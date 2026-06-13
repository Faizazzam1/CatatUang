import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/data/services/financial_service.dart';
import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(FinancialService());
  runApp(
    GetMaterialApp(
      title: "CatatUang",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF2563EB),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),
    ),
  );
}
