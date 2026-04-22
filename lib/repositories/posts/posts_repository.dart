import 'package:tech_task/core/errors/error_handler.dart';
import 'package:tech_task/models/posts/post_model.dart';
import 'package:tech_task/services/posts/posts_api_service.dart';

class PostsRepository {
  PostsRepository(this._apiService);

  final PostsApiService _apiService;

  Future<List<PostModel>> getPosts() async {
    try {
      final data = await _apiService.fetchPosts();

      return data.map(PostModel.fromJson).toList();
    } catch (error) {
      throw ErrorHandler.handle(error);
    }
  }
}
