import 'package:dio/dio.dart';
import 'package:pioneer_alpha_ltd_task/core/utils/app_constants.dart';
import 'package:pioneer_alpha_ltd_task/data/model/git_hub_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RepoService {
  final Dio dio = Dio();

  Future<List<RepositoryModel>> fetchRepositories({String query = 'Flutter'}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final response = await dio.get(
        AppConstants.apiBaseUrl,
        queryParameters: {
          'q': query,
          'sort': 'stars',
          'order': 'desc',
          'per_page': 50,
        },
      );

      List items = response.data['items'];
      List<RepositoryModel> repos = items.map((e) => RepositoryModel.fromJson(e)).toList();

      // Save to shared_preferences
      String jsonString = RepositoryModel.toJsonList(repos);
      await prefs.setString(AppConstants.cacheKey, jsonString);

      return repos;
    } catch (e) {
      // Return cached data if offline or on error
      String? cached = prefs.getString(AppConstants.cacheKey);
      if (cached != null) {
        return RepositoryModel.fromJsonList(cached);
      } else {
        return [];
      }
    }
  }
}
