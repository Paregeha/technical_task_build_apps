import 'package:tech_task/models/posts/post_model.dart';
import 'package:tech_task/models/posts/posts_sort_type.dart';

abstract class PostsState {
  const PostsState();
}

class PostsInitial extends PostsState {
  const PostsInitial();
}

class PostsLoading extends PostsState {
  const PostsLoading();
}

class PostsLoaded extends PostsState {
  const PostsLoaded({
    required this.allPosts,
    required this.visiblePosts,
    required this.selectedUserIds,
    required this.sortType,
  });

  final List<PostModel> allPosts;
  final List<PostModel> visiblePosts;
  final List<int> selectedUserIds;
  final PostsSortType sortType;
}

class PostsError extends PostsState {
  const PostsError(this.message);

  final String message;
}
