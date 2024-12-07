import 'package:dio/dio.dart';
import 'package:fixnow/config/config.dart';
import 'package:fixnow/domain/entities/post.dart';
import 'package:fixnow/domain/mappers/post_mapper.dart';
import 'package:fixnow/infrastructure/errors/custom_error.dart';

class ForumData {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  Future<Post> createPost(String username, String title, String content,
      String time, String uuid) async {
    try {
      final response = await dio.post('/forum/create/post', data: {
        "userUuid": uuid,
        "username": username,
        "title": title,
        "content": content,
        "time": time
      });

      final post = PostMapper.postJsonToEntity(response.data);
      return post;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw CustomError(e.response?.data['message']);
      }
      if (e.response?.statusCode == 401) {
        throw CustomError(e.response?.data['message']);
      }

      if (e.response?.statusCode == 404) {
        throw CustomError(e.response?.data['message']);
      }

      if (e.type == DioExceptionType.connectionError) {
        throw CustomError('Revisa tu conexión a internet');
      }
      if (e.response?.statusCode == 500) {
        throw CustomError(
            e.response?.data['message'] ?? 'Error al crear el post');
      }
      throw CustomError('Algo salió mal');
    } catch (e) {
      throw CustomError('Algo pasó');
    }
  }

  Future<List<Post>> getAllPost() async {
    try {
      final response = await dio.get('/forum/get/posts');

      final List<Post> allPost = [];
      for (final post in response.data ?? []) {
        allPost.add(PostMapper.postJsonToEntity(post));
      }
      return allPost;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw CustomError(e.response?.data['message']);
      }
      if (e.response?.statusCode == 401) {
        throw CustomError(e.response?.data['message']);
      }

      if (e.response?.statusCode == 404) {
        throw CustomError(e.response?.data['message']);
      }

      if (e.type == DioExceptionType.connectionError) {
        throw CustomError('Revisa tu conexión a internet');
      }
      if (e.response?.statusCode == 500) {
        throw CustomError(
            e.response?.data['message'] ?? 'Error al crear el post');
      }
      throw CustomError('Algo salió mal');
    } catch (e) {
      throw CustomError('Algo pasó');
    }
  }

  Future<List<Post>> getMyPost(String id) async {
    try {
      final response = await dio.post('/forum/get/posts/$id');
      final List<Post> myPost = [];
      for (final post in response.data ?? []) {
        myPost.add(PostMapper.postJsonToEntity(post));
      }
      return myPost;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw CustomError(e.response?.data['message']);
      }
      if (e.response?.statusCode == 401) {
        throw CustomError(e.response?.data['message']);
      }

      if (e.response?.statusCode == 404) {
        throw CustomError(e.response?.data['message']);
      }

      if (e.type == DioExceptionType.connectionError) {
        throw CustomError('Revisa tu conexión a internet');
      }
      if (e.response?.statusCode == 500) {
        throw CustomError(
            e.response?.data['message'] ?? 'Error al crear el post');
      }
      throw CustomError('Algo salió mal');
    } catch (e) {
      throw CustomError('Algo pasó');
    }
  }

  Future createComment(
      String username, String postUuid, String content, String time) async {
    try {
      final response = await dio.post('/forum/create/comment', data: {
        "username": username,
        "postUuid": postUuid,
        "content": content,
        "time": time
      });

      final comment = response.data['message'];
      return comment;

    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw CustomError(e.response?.data['message']);
      }
      if (e.response?.statusCode == 401) {
        throw CustomError(e.response?.data['message']);
      }

      if (e.response?.statusCode == 404) {
        throw CustomError(e.response?.data['message']);
      }

      if (e.type == DioExceptionType.connectionError) {
        throw CustomError('Revisa tu conexión a internet');
      }
      if (e.response?.statusCode == 500) {
        throw CustomError(
            e.response?.data['message'] ?? 'Error al crear el post');
      }
      throw CustomError('Algo salió mal');
    } catch (e) {
      throw CustomError('Algo pasó');
    }
  }

  Future getComments(String postId) async {
    try {
      final response =
          await dio.post('/forum/find/comments', data: {"postUuid": postId});
      final List<Map<String, dynamic>> allComments = [];

      for (final comment in response.data['data'] ?? []) {
        allComments.add(comment);
      }

      return allComments;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw CustomError(e.response?.data['message']);
      }
      if (e.response?.statusCode == 401) {
        throw CustomError(e.response?.data['message']);
      }

      if (e.response?.statusCode == 404) {
        throw CustomError(e.response?.data['message']);
      }

      if (e.type == DioExceptionType.connectionError) {
        throw CustomError('Revisa tu conexión a internet');
      }
      if (e.response?.statusCode == 500) {
        throw CustomError(
            e.response?.data['message'] ?? 'Error al crear el post');
      }
      throw CustomError('Algo salió mal');
    } catch (e) {
      throw CustomError('Algo pasó');
    }
  }
}
