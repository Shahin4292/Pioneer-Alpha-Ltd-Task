import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pioneer_alpha_ltd_task/controller/theme_controller.dart';
import 'package:pioneer_alpha_ltd_task/core/utils/dimensions.dart';
import 'package:pioneer_alpha_ltd_task/data/model/git_hub_model.dart';
import 'package:url_launcher/url_launcher.dart';

class RepositoryDetailsScreen extends StatelessWidget {
  final RepositoryModel repository;
  final ThemeController themeController = Get.find();
   RepositoryDetailsScreen({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(repository.name),
        actions: [
          IconButton(onPressed: themeController.toggleTheme, icon: Icon(Icons.brightness_6)),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [

            Row(
              spacing: Dimensions.paddingSizeDefault,
              children: [

                CircleAvatar(
                  radius: Dimensions.extraLarge,
                  backgroundImage: NetworkImage(repository.ownerAvatarUrl),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        repository.ownerName,
                        style: TextStyle(
                          fontSize: Dimensions.fontSizeLarge,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                      Text(
                        "⭐ ${repository.stars} stars",
                        style: const TextStyle(fontSize: Dimensions.paddingSizeDefault),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: Dimensions.paddingSizeLarge),

            Text(
              "Description:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.fontSizeLarge),
            ),

            const SizedBox(height: Dimensions.paddingSizeSmall),

            Text(
              repository.description.isNotEmpty
                  ? repository.description
                  : "No description provided.",
              style: TextStyle(fontSize: Dimensions.fontSizeDefault,),
            ),

            const SizedBox(height: Dimensions.paddingSizeLarge),

            Text(
              "Last Updated:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.fontSizeLarge,),
            ),

            const SizedBox(height: Dimensions.paddingSizeSmall),

            Text(
              "${repository.lastUpdated.toLocal()}".split(' ')[0],
              style: TextStyle(fontSize: Dimensions.fontSizeDefault,),
            ),

            const SizedBox(height: Dimensions.paddingSizeLarge),

            Text(
              "Repository Link:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.fontSizeLarge,),
            ),

            const SizedBox(height: Dimensions.paddingSizeSmall),

            InkWell(
              onTap: () async {
                final url = Uri.parse(repository.htmlUrl);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Could not open ${repository.htmlUrl}')),
                  );
                }
              },
              child: Text(
                repository.htmlUrl,
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  fontSize: Dimensions.fontSizeDefault,
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
