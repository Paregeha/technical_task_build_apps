import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_task/blocs/posts/posts_bloc.dart';
import 'package:tech_task/blocs/posts/posts_event.dart';
import 'package:tech_task/blocs/posts/posts_state.dart';
import 'package:tech_task/models/posts/post_model.dart';
import 'package:tech_task/models/posts/posts_sort_type.dart';
import 'package:tech_task/resources/app_colors.dart';
import 'package:tech_task/resources/app_decorations.dart';
import 'package:tech_task/resources/app_fonts.dart';
import 'package:tech_task/routes/app_routes.dart';
import 'package:tech_task/widgets/cards/custom_card_post_widget.dart';
import 'package:tech_task/widgets/chips/active_users_chip.dart';
import 'package:tech_task/widgets/dialogs/posts_filter_dialog.dart';
import 'package:tech_task/widgets/views/posts_error_view.dart';
import 'package:tech_task/widgets/views/posts_loading_view.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<PostsBloc>().add(const LoadPostsEvent());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _showFilterDialog(PostsLoaded state) async {
    final userIds = state.allPosts.map((post) => post.userId).toSet().toList()
      ..sort();

    final selectedIds = await showDialog<List<int>>(
      context: context,
      builder: (_) => PostsFilterDialog(
        userIds: userIds,
        initialSelectedIds: state.selectedUserIds,
      ),
    );

    if (!mounted || selectedIds == null) return;

    context.read<PostsBloc>().add(FilterPostsByUsersEvent(selectedIds));
  }

  void _toggleSort(PostsLoaded state) {
    final newSortType = state.sortType == PostsSortType.ascending
        ? PostsSortType.descending
        : PostsSortType.ascending;

    context.read<PostsBloc>().add(SortPostsEvent(newSortType));
  }

  PreferredSizeWidget _buildAppBar(PostsLoaded state) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: const Text(
        'Posts',
        style: TextStyle(
          color: AppColors.black,
          fontFamily: AppFonts.fontFamily,
          fontWeight: AppFonts.bold,
          fontSize: 24.0,
        ),
      ),
      centerTitle: false,
      titleSpacing: 16.0,
      actions: [
        Row(
          children: [
            Stack(
              children: [
                IconButton(
                  tooltip: state.sortType == PostsSortType.ascending
                      ? 'Sorting: ascending'
                      : 'Sorting: descending',
                  onPressed: () => _toggleSort(state),
                  icon: const Icon(
                    Icons.swap_vert_rounded,
                    color: AppColors.black,
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Icon(
                    state.sortType == PostsSortType.ascending
                        ? Icons.arrow_upward_rounded
                        : Icons.arrow_downward_rounded,
                    size: 12.0,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                IconButton(
                  tooltip: 'Filter by users',
                  onPressed: () => _showFilterDialog(state),
                  icon: Icon(
                    state.selectedUserIds.isNotEmpty
                        ? Icons.filter_alt_outlined
                        : Icons.filter_alt_off_outlined,
                    color: AppColors.black,
                  ),
                ),
                if (state.selectedUserIds.isNotEmpty)
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: AppColors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 6.0),
          ],
        ),
      ],
    );
  }

  Widget _buildPostsList(List<PostModel> posts) {
    return Stack(
      children: [
        ScrollConfiguration(
          behavior: const _NoGlowScrollBehavior(),
          child: Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            radius: const Radius.circular(12.0),
            child: ListView.separated(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
              itemCount: posts.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 12.0),
              itemBuilder: (context, index) {
                final post = posts[index];

                return CustomCardPostWidget(
                  post: post,
                  onTap: () {
                    context.push(AppRoutes.details, extra: post);
                  },
                );
              },
            ),
          ),
        ),
        IgnorePointer(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(height: 18.0, decoration: AppDecorations.topFade),
          ),
        ),
      ],
    );
  }

  Widget _buildLoaded(PostsLoaded state) {
    final posts = state.visiblePosts;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(state),
      body: Column(
        children: [
          if (state.selectedUserIds.isNotEmpty)
            ActiveUsersChip(selectedUserIds: state.selectedUserIds),
          Expanded(child: _buildPostsList(posts)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is PostsLoading) {
          return const PostsLoadingView();
        }

        if (state is PostsError) {
          return PostsErrorView(
            message: state.message,
            onRetry: () {
              context.read<PostsBloc>().add(const LoadPostsEvent());
            },
          );
        }

        if (state is PostsLoaded) {
          return _buildLoaded(state);
        }

        return const Scaffold(
          backgroundColor: AppColors.background,
          body: SizedBox.shrink(),
        );
      },
    );
  }
}

class _NoGlowScrollBehavior extends ScrollBehavior {
  const _NoGlowScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
