import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_task/blocs/posts/posts_bloc.dart';
import 'package:tech_task/repositories/posts/posts_repository.dart';
import 'package:tech_task/routes/app_router.dart';
import 'package:tech_task/services/posts/posts_api_service.dart';

void main() {
  final postsApiService = PostsApiService();
  final postsRepository = PostsRepository(postsApiService);

  runApp(MyApp(postsRepository: postsRepository));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.postsRepository});

  final PostsRepository postsRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: postsRepository,
      child: BlocProvider(
        create: (_) => PostsBloc(postsRepository),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Tech Task',
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
