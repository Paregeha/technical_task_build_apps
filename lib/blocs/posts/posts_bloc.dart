import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_task/blocs/posts/posts_event.dart';
import 'package:tech_task/blocs/posts/posts_state.dart';
import 'package:tech_task/models/posts/post_model.dart';
import 'package:tech_task/models/posts/posts_sort_type.dart';
import 'package:tech_task/repositories/posts/posts_repository.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc(this._postsRepository) : super(const PostsInitial()) {
    on<LoadPostsEvent>(_onLoadPosts);
    on<FilterPostsByUsersEvent>(_onFilterPostsByUsers);
    on<SortPostsEvent>(_onSortPosts);
  }

  static const List<int> _defaultSelectedUserIds = [];
  static const PostsSortType _defaultSortType = PostsSortType.ascending;

  final PostsRepository _postsRepository;

  Future<void> _onLoadPosts(
    LoadPostsEvent event,
    Emitter<PostsState> emit,
  ) async {
    emit(const PostsLoading());

    try {
      final posts = await _postsRepository.getPosts();

      await Future.delayed(const Duration(milliseconds: 300));

      final visiblePosts = _applyFilterAndSort(
        allPosts: posts,
        selectedUserIds: _defaultSelectedUserIds,
        sortType: _defaultSortType,
      );

      emit(
        PostsLoaded(
          allPosts: posts,
          visiblePosts: visiblePosts,
          selectedUserIds: _defaultSelectedUserIds,
          sortType: _defaultSortType,
        ),
      );
    } catch (error) {
      emit(PostsError(error.toString()));
    }
  }

  void _onFilterPostsByUsers(
    FilterPostsByUsersEvent event,
    Emitter<PostsState> emit,
  ) {
    final currentState = state;
    if (currentState is! PostsLoaded) return;

    final visiblePosts = _applyFilterAndSort(
      allPosts: currentState.allPosts,
      selectedUserIds: event.userIds,
      sortType: currentState.sortType,
    );

    emit(
      PostsLoaded(
        allPosts: currentState.allPosts,
        visiblePosts: visiblePosts,
        selectedUserIds: event.userIds,
        sortType: currentState.sortType,
      ),
    );
  }

  void _onSortPosts(SortPostsEvent event, Emitter<PostsState> emit) {
    final currentState = state;
    if (currentState is! PostsLoaded) return;

    final visiblePosts = _applyFilterAndSort(
      allPosts: currentState.allPosts,
      selectedUserIds: currentState.selectedUserIds,
      sortType: event.sortType,
    );

    emit(
      PostsLoaded(
        allPosts: currentState.allPosts,
        visiblePosts: visiblePosts,
        selectedUserIds: currentState.selectedUserIds,
        sortType: event.sortType,
      ),
    );
  }

  List<PostModel> _applyFilterAndSort({
    required List<PostModel> allPosts,
    required List<int> selectedUserIds,
    required PostsSortType sortType,
  }) {
    List<PostModel> result = List<PostModel>.from(allPosts);

    if (selectedUserIds.isNotEmpty) {
      result = result
          .where((post) => selectedUserIds.contains(post.userId))
          .toList();
    }

    result.sort((a, b) {
      if (sortType == PostsSortType.ascending) {
        return a.id.compareTo(b.id);
      }
      return b.id.compareTo(a.id);
    });

    return result;
  }
}
