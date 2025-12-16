import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pioneer_alpha_ltd_task/controller/git_hub_search_controller.dart';
import 'package:pioneer_alpha_ltd_task/controller/theme_controller.dart';
import 'package:pioneer_alpha_ltd_task/data/model/git_hub_model.dart';
import 'package:pioneer_alpha_ltd_task/features/git_hub_details/screens/git_hub_repo_details_screen.dart';


class GitHubHomeScreen extends StatelessWidget {
  final RepoController controller = Get.find();
  final ThemeController themeController = Get.find();
  GitHubHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GitHub Repositories"),
        actions: [
          IconButton(onPressed: themeController.toggleTheme, icon: Icon(Icons.brightness_6)),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Stars') controller.sortBy(SortOption.stars);
              if (value == 'Updated') controller.sortBy(SortOption.updated);
            },
            itemBuilder: (_) => [
              PopupMenuItem(value: 'Stars', child: Text('Sort by Stars')),
              PopupMenuItem(value: 'Updated', child: Text('Sort by Last Updated')),
            ],
          ),
        ],
      ),

      body: Obx(() {
        if (controller.isLoading.value) return Center(child: CircularProgressIndicator());
        if (controller.repositories.isEmpty) return Center(child: Text("No repositories found."));
        return ListView.builder(
          itemCount: controller.repositories.length,
          itemBuilder: (_, index) {
            RepositoryModel repo = controller.repositories[index];
            final firstLetter = repo.name.isNotEmpty ? repo.name[0].toUpperCase() : '?';
            return GestureDetector(
              onTap: (){
                Get.to(RepositoryDetailsScreen(repository: repo,));
              },
              child: Card(
                elevation: 1,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(firstLetter, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  title: Text(repo.name),
                  subtitle: Text("Owner: ${repo.ownerName}"),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("⭐ ${repo.stars}"),
                      Text("${repo.lastUpdated.toLocal()}".split(' ')[0]),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
