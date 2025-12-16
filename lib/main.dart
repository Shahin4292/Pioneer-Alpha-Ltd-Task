import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/git_hub_search_controller.dart';
import 'controller/theme_controller.dart';
import 'domain/repository/git_hub_home_repo.dart';
import 'features/git_hub_home/screens/git_hub_home_screen.dart';

void main() {
  final repoService = RepoService();
  final repoController = RepoController(repoService);

  runApp(MyApp(controller: repoController));
}

class MyApp extends StatelessWidget {
  final RepoController controller;
  MyApp({super.key, required this.controller}) {
    Get.put(controller);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    return Obx(() => GetMaterialApp(
      title: 'GitHub Explorer',
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: themeController.themeMode.value,
      debugShowCheckedModeBanner: false,
      home: GitHubHomeScreen(),
    ),
    );
  }
}
