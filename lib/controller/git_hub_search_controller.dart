import 'package:get/get.dart';
import '../model/git_hub_model.dart';
import '../features/git_hub_search/repository/git_hub_search_repo.dart';

enum SortOption { stars, updated }

class RepoController extends GetxController {
  final RepoService service;
  RepoController(this.service);

  var repositories = <RepositoryModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRepos();
  }

  void fetchRepos() async {
    isLoading.value = true;
    repositories.value = await service.fetchRepositories();
    isLoading.value = false;
  }

  void sortBy(SortOption option) {
    if (option == SortOption.stars) {
      repositories.sort((a, b) => b.stars.compareTo(a.stars));
    } else if (option == SortOption.updated) {
      repositories.sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated));
    }
  }
}
