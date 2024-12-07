import 'package:fixnow/domain/entities/post.dart';
import 'package:fixnow/infrastructure/datasources/forum_data.dart';
import 'package:fixnow/infrastructure/errors/custom_error.dart';
import 'package:fixnow/infrastructure/inputs/forum/content.dart';
import 'package:fixnow/infrastructure/inputs/forum/post_title.dart';
import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

enum ForumOption {
  all,
  myPost,
}

final forumProvider =
    StateNotifierProvider.autoDispose<ForumNotifier, ForumState>((ref) {
  final forumData = ForumData();
  final authState = AuthState();
  return ForumNotifier(forumData: forumData, authState: authState);
});

class ForumState {
  final TitlePost title;
  final ContentPost content;
  final bool isValidPost;
  final bool isPosting;
  final bool isFormPosted;
  final List<Post> listPost;
  final List<Post> myListPost;
  final String message;
  final ForumOption forumOption;
  final bool isLoading;
  final List<Map<String, dynamic>> listComments;
  final bool isLoadingComments;
  const ForumState(
      {this.title = const TitlePost.pure(),
      this.content = const ContentPost.pure(),
      this.isValidPost = false,
      this.isPosting = false,
      this.isFormPosted = false,
      this.listPost = const [],
      this.myListPost = const [],
      this.message = '',
      this.forumOption = ForumOption.all,
      this.isLoading = true,
      this.listComments = const [],
      this.isLoadingComments = false});

  ForumState copyWith(
          {TitlePost? title,
          String? username,
          ContentPost? content,
          bool? isValidPost,
          bool? isPosting,
          bool? isFormPosted,
          List<Post>? listPost,
          List<Post>? myListPost,
          String? message,
          ForumOption? forumOption,
          bool? isLoading,
          List<Map<String, dynamic>>? listComments,
          bool? isLoadingComments}) =>
      ForumState(
          title: title ?? this.title,
          content: content ?? this.content,
          isValidPost: isValidPost ?? this.isValidPost,
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          listPost: listPost ?? this.listPost,
          myListPost: myListPost ?? this.myListPost,
          message: message ?? this.message,
          forumOption: forumOption ?? this.forumOption,
          isLoading: isLoading ?? this.isLoading,
          listComments: listComments ?? this.listComments,
          isLoadingComments: isLoadingComments ?? this.isLoadingComments);
}

class ForumNotifier extends StateNotifier<ForumState> {
  final ForumData forumData;
  final AuthState authState;
  ForumNotifier({required this.forumData, required this.authState})
      : super(const ForumState()) {
    getAllPost();
    getMyPost();
  }

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

  Future<void> getAllPost() async {
    try {
      state = state.copyWith(isLoading: true);
      final List<Post> allPost = await forumData.getAllPost();
      state = state.copyWith(message: '', listPost: allPost, isLoading: false);
    } on CustomError catch (e) {
      state = state.copyWith(isLoading: false, message: e.message);
    }
    state = state.copyWith(isLoading: false);
  }

  Future<void> createPost(String username, String userId) async {
    _touchEveryField();
    if (!state.isValidPost) return;
    state = state.copyWith(isPosting: true);
    try {
      final String time = DateTime.now().toIso8601String();
      final newPost = await forumData.createPost(
          username, state.title.value, state.content.value, time, userId);
      state = state.copyWith(
          myListPost: [...state.myListPost, newPost], isFormPosted: true);
    } on CustomError catch (e) {
      state = state.copyWith(
          isPosting: false, isFormPosted: false, message: e.message);
    }
    state = state.copyWith(isPosting: false, isFormPosted: false, message: '');
  }

  Future<void> getMyPost() async {
    try {
      state = state.copyWith(isLoading: true);
      final List<Post> allPost = await forumData.getMyPost(authState.user!.id!);
      state = state.copyWith(message: '', listPost: allPost, isLoading: false);
    } on CustomError catch (e) {
      state = state.copyWith(
          isPosting: false, isFormPosted: false, message: e.message);
    }
    state = state.copyWith(isPosting: false, isFormPosted: false);
  }

  updateOption(ForumOption value) {
    state = state.copyWith(forumOption: value);
  }

  Future getComments(String postId) async {
    state = state.copyWith(isLoadingComments: true);

    try {
      final comments = await forumData.getComments(postId);
      state = state.copyWith(listComments: comments, isLoadingComments: false);
    } on CustomError catch (e) {
      state = state.copyWith(
          message: e.message, listComments: [], isLoadingComments: false);
    }
    state = state.copyWith(isLoadingComments: false);
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
