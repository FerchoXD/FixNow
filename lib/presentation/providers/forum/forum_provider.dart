import 'package:fixnow/domain/entities/post.dart';
import 'package:fixnow/infrastructure/datasources/forum_data.dart';
import 'package:fixnow/infrastructure/inputs/forum/content.dart';
import 'package:fixnow/infrastructure/inputs/forum/post_title.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

final forumProvider = StateNotifierProvider<ForumNotifier, ForumState>((ref) {
  final forumData = ForumData();
  return ForumNotifier(forumData: forumData);
});

class ForumState {
  final TitlePost title;
  final ContentPost content;
  final bool isValidPost;
  final bool isPosting;
  final bool isFormPosted;
  final List<Post> listPost;

  const ForumState(
      {this.title = const TitlePost.pure(),
      this.content = const ContentPost.pure(),
      this.isValidPost = false,
      this.isPosting = false,
      this.isFormPosted = false,
      this.listPost = const []});

  ForumState copyWith({
    TitlePost? title,
    String? username,
    ContentPost? content,
    bool? isValidPost,
    bool? isPosting,
    bool? isFormPosted,
    List<Post>? listPost,
  }) =>
      ForumState(
          title: title ?? this.title,
          content: content ?? this.content,
          isValidPost: isValidPost ?? this.isValidPost,
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          listPost: listPost ?? this.listPost);
}

class ForumNotifier extends StateNotifier<ForumState> {
  final ForumData forumData;
  ForumNotifier({required this.forumData}) : super(const ForumState());

  onChangedTitlePost(String value) {
    final newTitle = TitlePost.dirty(value);
    state = state.copyWith(
        title: newTitle, isValidPost: Formz.validate([state.content]));
  }

  onChangedContentPost(String value) {
    final newContentPost = ContentPost.dirty(value);
    state = state.copyWith(
        content: newContentPost, isValidPost: Formz.validate([state.title]));
  }

  Future<void> createPost(String username) async {
    _touchEveryField();
    if (!state.isValidPost) return;
    state = state.copyWith(isPosting: true);
    try {
      final String time = DateTime.now().toIso8601String();
      final newPost = await forumData.createPost(
          username, state.title.value, state.content.value, time);
      state = state.copyWith(listPost: [...state.listPost, newPost], isFormPosted: true);
    } catch (e) {
      state = state.copyWith(isPosting: false, isFormPosted: false);
      throw Error();
    }
    state = state.copyWith(isPosting: false, isFormPosted: false);
  }

  _touchEveryField() {
    final title = TitlePost.dirty(state.title.value);
    final content = ContentPost.dirty(state.content.value);
    state = state.copyWith(
        isFormPosted: true,
        title: title,
        content: content,
        isValidPost: Formz.validate([title, content]));
  }
}
