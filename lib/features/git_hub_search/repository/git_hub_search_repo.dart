import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:pioneer_alpha_ltd_task/model/git_hub_model.dart';
import 'package:pioneer_alpha_ltd_task/utils/app_constants.dart';

class GitHubSearchRepo {

  final Dio _dio = Dio(BaseOptions(baseUrl: AppConstants.apiBaseUrl));

  Future<GitHubModel?> getUser(String username) async {
    try {
      final response = await _dio.get('${AppConstants.searchUrl}$username${AppConstants.sortUrl}');

      debugPrint('Fetching user data for: ${AppConstants.searchUrl}$username${AppConstants.sortUrl}');
      debugPrint('Response status: ${response.statusCode}');

      if (response.statusCode == 200 && response.data != null) {
        return GitHubModel.fromJson(response.data);
      } else {
        debugPrint('Unexpected response: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      debugPrint('Dio error: ${e.message}');
      if (e.response != null) {
        debugPrint('Response data: ${e.response?.data}');
      }
      return null;
    } catch (e) {
      debugPrint('Unknown error: $e');
      return null;
    }
  }
}
