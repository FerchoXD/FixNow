import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Para File

class EditPhotoGallery extends StatefulWidget {
  final List<String> profileImages;

  const EditPhotoGallery({super.key, required this.profileImages});

  @override
  State<EditPhotoGallery> createState() => _EditPhotoGalleryState();
}

class _EditPhotoGalleryState extends State<EditPhotoGallery> {
  late List<String> localImages;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    localImages = List.from(widget.profileImages);
  }

  void _removeImage(String imageUrl) {
    setState(() {
      localImages.remove(imageUrl);
    });
  }

  Future<void> _addImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        localImages
            .add(pickedFile.path); // Se agrega la nueva imagen a la lista
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 250,
          child: localImages.isNotEmpty
              ? ListView.builder(
                  scrollDirection: Axis.horizontal, // Desplazamiento horizontal
                  itemCount: localImages.length,
                  itemBuilder: (context, index) {
                    final imageUrl = localImages[index];
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 250, // Ajusta el ancho de las imágenes
                            child: imageUrl.startsWith(
                                    'http') // Verifica si es una URL
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.error,
                                                  color: Colors.red),
                                    ),
                                  )
                                : FutureBuilder<File>(
                                    future: Future.value(File(imageUrl)),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (snapshot.hasError) {
                                        return const Icon(Icons.error,
                                            color: Colors.red);
                                      } else if (snapshot.hasData) {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.file(
                                            snapshot.data!, // Cargar la imagen
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      } else {
                                        return const SizedBox(); // En caso de que no haya datos
                                      }
                                    },
                                  ),
                          ),
                        ),
                        // Icono de eliminación
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () => _removeImage(imageUrl),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.8),
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(6.0),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                )
              : const Center(
                  child: Text(
                    "No hay imágenes disponibles.",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
        ),
        // Botón para agregar una imagen
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _addImage,
              child: const Text("Agregar imagen"),
            ),
          ),
        ),
      ],
    );
  }
}
