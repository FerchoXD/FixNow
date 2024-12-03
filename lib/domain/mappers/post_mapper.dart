import 'package:fixnow/domain/entities/post.dart';

class PostMapper {
  static Post postJsonToEntity(Map<String, dynamic> json) => Post(
      uuid: json['uuid'],
      id: json['_id'],
      username: json['username'],
      title: json['title'],
      content: json['content'],
      time: json['time'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt']);
}
