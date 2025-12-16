import 'dart:convert';

class RepositoryModel {
  final String name;
  final String description;
  final String ownerName;
  final String ownerAvatarUrl;
  final int stars;
  final DateTime lastUpdated;
  final String htmlUrl;

  RepositoryModel({
    required this.name,
    required this.description,
    required this.ownerName,
    required this.ownerAvatarUrl,
    required this.stars,
    required this.lastUpdated,
    required this.htmlUrl,
  });

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      ownerName: json['owner']?['login'] ?? '',
      ownerAvatarUrl: json['owner']?['avatar_url'] ?? '',
      stars: json['stargazers_count'] ?? 0,
      lastUpdated: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
      htmlUrl: json['html_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'ownerName': ownerName,
    'ownerAvatarUrl': ownerAvatarUrl,
    'stars': stars,
    'lastUpdated': lastUpdated.toIso8601String(),
    'htmlUrl': htmlUrl,
  };

  String get formattedDate {
    return '${lastUpdated.month.toString().padLeft(2, '0')}-'
        '${lastUpdated.day.toString().padLeft(2, '0')}-'
        '${lastUpdated.year} '
        '${lastUpdated.hour.toString().padLeft(2, '0')}:'
        '${lastUpdated.minute.toString().padLeft(2, '0')}';
  }

  static List<RepositoryModel> fromJsonList(String jsonString) {
    List list = json.decode(jsonString);
    return list.map((e) => RepositoryModel.fromJson(e)).toList();
  }

  static String toJsonList(List<RepositoryModel> repos) {
    List list = repos.map((e) => e.toJson()).toList();
    return json.encode(list);
  }
}

