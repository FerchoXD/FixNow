import 'package:fixnow/domain/entities/comment.dart';

class CommentMapper {
  static Comment commentJsonToEntity(Map<String, dynamic> json) => Comment(
        status: json['status'] as String,
        uuid: json['uuid'] as String,
        username: json['username'] as String,
        content: json['content'] as String,
        time: DateTime.parse(json['time'] as String),
      );
}
