import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_task/models/posts/post_model.dart';
import 'package:tech_task/pages/posts/post_details_page.dart';
import 'package:tech_task/pages/posts/posts_page.dart';
import 'package:tech_task/routes/app_routes.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.posts,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const PostsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: AppRoutes.details,
        pageBuilder: (context, state) {
          final post = state.extra as PostModel;

          return CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 300),
            reverseTransitionDuration: const Duration(milliseconds: 250),
            child: PostDetailsPage(post: post),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  final offsetAnimation =
                      Tween<Offset>(
                        begin: const Offset(0.12, 0),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutCubic,
                        ),
                      );

                  final fadeAnimation = CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                  );

                  return FadeTransition(
                    opacity: fadeAnimation,
                    child: SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    ),
                  );
                },
          );
        },
      ),
    ],
  );
}
