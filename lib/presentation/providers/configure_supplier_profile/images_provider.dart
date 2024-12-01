import 'dart:io';
import 'package:fixnow/infrastructure/datasources/supplier_data.dart';
import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final imagesProvider =
    StateNotifierProvider<ImagesNotifier, ImagesState>((ref) {
  final supplierData = SupplierData();
  return ImagesNotifier(supplierData: supplierData, ref: ref);
});

class ImagesState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final List<File> images;
  final bool isCompleted;

  const ImagesState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.images = const [],
    this.isCompleted = false,
  });

  ImagesState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    List<File>? images,
    bool? isCompleted,
  }) =>
      ImagesState(
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isValid: isValid ?? this.isValid,
          images: images ?? this.images,
          isCompleted: isCompleted ?? this.isCompleted);
}

class ImagesNotifier extends StateNotifier<ImagesState> {
  final SupplierData supplierData;
  final Ref ref;

  ImagesNotifier({required this.supplierData, required this.ref})
      : super(const ImagesState());

  onImagesChanged(List<File> images) async {
    print(images);
    state = state.copyWith(images: images);
  
  }
  

  onFormSubmit(String id) async {
    state = state.copyWith(isPosting: true);
    try {
      final supplier = await supplierData.sendImages(id, state.images);
      ref.read(authProvider.notifier).setUserCustomerOrSupplier(supplier);
      state = state.copyWith(isCompleted: true);
    } catch (e) {
      state = state.copyWith(isPosting: false);
      throw Error();
    }
    state = state.copyWith(isPosting: false);
  }
}
