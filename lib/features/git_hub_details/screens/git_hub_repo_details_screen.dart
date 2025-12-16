import 'package:flutter/material.dart';
import 'package:pioneer_alpha_ltd_task/model/git_hub_model.dart';
import 'package:url_launcher/url_launcher.dart';

class RepositoryDetailsScreen extends StatelessWidget {
  final RepositoryModel repository;

  const RepositoryDetailsScreen({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(repository.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Owner Info
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(repository.ownerAvatarUrl),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        repository.ownerName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "⭐ ${repository.stars} stars",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Repository Description
            const Text(
              "Description:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              repository.description.isNotEmpty
                  ? repository.description
                  : "No description provided.",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // Last Updated
            const Text(
              "Last Updated:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              "${repository.lastUpdated.toLocal()}".split(' ')[0],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // Repository Link
            const Text(
              "Repository Link:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
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
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
