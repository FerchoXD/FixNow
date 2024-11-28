import 'package:dio/dio.dart';
import 'package:fixnow/domain/entities/post.dart';
import 'package:fixnow/domain/mappers/post_mapper.dart';

class ForumData {
  final dio = Dio(BaseOptions(baseUrl: 'http://192.168.0.145:3003/api/v1'));

  Future<Post> createPost(
      String username, String title, String content, String time) async {
    try {
      final response = await dio.post('/forum/create/post', data: {
        "username": username,
        "title": title,
        "content": content,
        "time": time
      });

      final post = PostMapper.postJsonToEntity(response.data);
      return post;
    } catch (e) {
      throw Error();
    }
  }
}
