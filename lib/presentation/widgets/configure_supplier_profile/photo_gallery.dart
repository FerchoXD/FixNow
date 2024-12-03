import 'package:fixnow/presentation/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class PhotoGallery extends ConsumerStatefulWidget {
  const PhotoGallery({super.key});

  @override
  _PhotoGalleryState createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends ConsumerState<PhotoGallery> {
  final List<File> _images = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    if (_images.length >= 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No puedes agregar más de 10 imágenes')),
      );
      return;
    }

    if (await _requestPermission()) {
      _openGallery();
    }
  }

  Future<bool> _requestPermission() async {
    var status = await Permission.storage.status;

    if (status.isGranted) {
      return true;
    } else if (status.isDenied || status.isGranted) {
      status = await Permission.camera.request();

      if (status.isGranted) {
        return true;
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Permiso denegado para acceder a la galería')),
        );
        return false;
      }
    } else if (status.isPermanentlyDenied) {
      _showSettingsDialog();
      return false;
    } else if (status.isPermanentlyDenied) {
      _showSettingsDialog();
      return false;
    }

    return false;
  }

  Future<void> _openGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
      ref.read(imagesProvider.notifier).onImagesChanged(_images);
    }
  }

  void _showSettingsDialog() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
            'Permiso denegado permanentemente. Habilítalo en Configuración.'),
        action: SnackBarAction(
          label: 'Abrir Configuración',
          onPressed: () async {
            await openAppSettings();
          },
        ),
      ),
    );
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
    ref.read(imagesProvider.notifier).onImagesChanged(_images);
  }

  @override
  Widget build(BuildContext context) {
    showMessage(BuildContext context, String message) {
      Fluttertoast.showToast(
        msg: message,
        fontSize: 16,
        backgroundColor: const Color.fromARGB(255, 255, 229, 227),
        textColor: Colors.red.shade300,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }

    ref.listen(imagesProvider, (previous, next) {
      if (next.message.isEmpty) return;
      showMessage(context, next.message);
    });

    final colors = Theme.of(context).colorScheme;
    final authState = ref.watch(authProvider);
    void showToast(String message) {
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: colors.primary.withOpacity(0.1),
        textColor: colors.primary,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add_a_photo),
                label: const Text("Agregar Imagen"),
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.secondary,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: colors.primary, width: 0.2),
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Image.file(
                        _images[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: GestureDetector(
                        onTap: () => _removeImage(index),
                        child: const CircleAvatar(
                          backgroundColor: Color(0xFFE05454),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  if (_images.length < 2) {
                    return showToast(
                        'Ingresa al menos 2 imágenes para continuar');
                  }

                  ref
                      .read(imagesProvider.notifier)
                      .onFormSubmit(authState.user!.id!);
                },
                child: const Text(
                  'Guardar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
