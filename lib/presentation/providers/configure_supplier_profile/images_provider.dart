import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:fixnow/infrastructure/datasources/supplier_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;

final imagesProvider = StateNotifierProvider((ref) {
  final supplierData = SupplierData();
  return ImagesNotifier(supplierData: supplierData);
});

class ImagesState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final List<String> images;

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
    List<String>? images,
  }) =>
      ImagesState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        images: images ?? this.images,
      );
}

class ImagesNotifier extends StateNotifier<ImagesState> {
  final SupplierData supplierData;
  ImagesNotifier({required this.supplierData}) : super(const ImagesState());

  onImagesChanged(List<File> images) async {
    List<String> base64Images = [];
    List<int> imageSizes =
        []; // Para almacenar los tamaños de las imágenes comprimidas en base64

    for (var image in images) {
      try {
        List<int> imageBytes = await image.readAsBytes();

        img.Image? decodedImage =
            img.decodeImage(Uint8List.fromList(imageBytes));

        if (decodedImage != null) {
          List<int> compressedImageBytes =
              img.encodeJpg(decodedImage, quality: 10);

          String base64Image = base64Encode(compressedImageBytes);

          int base64Size = base64Image.length;

          print(
              "Tamaño de la imagen comprimida en base64: $base64Size caracteres");

          base64Images.add(base64Image);

          imageSizes.add(base64Size);
        }
      } catch (e) {
        throw Error();
      }
    }

    state = state.copyWith(images: base64Images);

    // Si necesitas acceder a los tamaños de las imágenes en base64, puedes usarlos aquí
    print("Tamaños de las imágenes comprimidas en base64: $imageSizes");
  }

  onFormSubmit(String id) async {
    state = state.copyWith(isPosting: true);

    try {
      await supplierData.sendImages(id, state.images);
    } catch (e) {
      state = state.copyWith(isPosting: false);
      throw Error();
    }
    state = state.copyWith(isPosting: false);
  }
}
