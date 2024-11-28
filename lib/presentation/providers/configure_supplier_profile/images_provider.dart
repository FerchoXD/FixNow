import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final imagesProvider = StateNotifierProvider((ref) {
  return ImagesNotifier();
});

class ImagesState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final List<File> images;

  const ImagesState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.images = const [],
  });

  ImagesState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    List<File>? images,
  }) =>
      ImagesState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        images: images ?? this.images,
      );
}

class ImagesNotifier extends StateNotifier<ImagesState> {
  ImagesNotifier() : super(const ImagesState());

  onImagesChanged(List<File> images) async {
    List<String> base64Images = [];

    for (var image in images) {
      try {
        List<int> imageBytes = await image.readAsBytes();
        String base64Image = base64Encode(imageBytes);
        base64Images.add(base64Image);
      } catch (e) {
        throw Error();
      }
    }
    state = state.copyWith(images: images);
  }
}
