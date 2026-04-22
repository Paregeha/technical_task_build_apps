import 'package:tech_task/models/posts/posts_sort_type.dart';

abstract class PostsEvent {
  const PostsEvent();
}

class LoadPostsEvent extends PostsEvent {
  const LoadPostsEvent();
}

class FilterPostsByUsersEvent extends PostsEvent {
  const FilterPostsByUsersEvent(this.userIds);

  final List<int> userIds;
}

class SortPostsEvent extends PostsEvent {
  const SortPostsEvent(this.sortType);

  final PostsSortType sortType;
}
