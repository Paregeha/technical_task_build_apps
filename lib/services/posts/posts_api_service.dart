import 'package:dio/dio.dart';

class PostsApiService {
  PostsApiService({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: 'https://jsonplaceholder.typicode.com',
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
              headers: {'Accept': 'application/json'},
            ),
          );

  final Dio _dio;

  Future<List<Map<String, dynamic>>> fetchPosts() async {
    final response = await _dio.get('/posts');

    if (response.statusCode == 200 && response.data is List) {
      return (response.data as List)
          .map((item) => item as Map<String, dynamic>)
          .toList();
    }

    throw Exception('Failed to load posts');
  }
}
