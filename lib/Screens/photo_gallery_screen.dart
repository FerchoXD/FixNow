import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class PhotoGalleryScreen extends StatefulWidget {
  const PhotoGalleryScreen({super.key});

  @override
  _PhotoGalleryScreenState createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  final List<File> _images = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    if (_images.length >= 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No puedes agregar más de 10 imágenes')),
      );
      return;
    }

    // Intentamos pedir permiso de almacenamiento
    if (await _requestPermission()) {
      _openGallery();
    }
  }

  Future<bool> _requestPermission() async {
    var status = await Permission.storage.status;

    // Si ya tiene permiso
    if (status.isGranted) {
      return true;
    } 
    // Si el permiso está denegado o restringido, solicitamos permiso
    else if (status.isDenied || status.isRestricted) {
      status = await Permission.storage.request();

      if (status.isGranted) {
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permiso denegado para acceder a la galería')),
        );
        return false;
      }
    } 
    // Si el permiso está denegado permanentemente, sugerimos abrir configuración
    else if (status.isPermanentlyDenied) {
      _showSettingsDialog();
      return false;
    }

    return false;
  }

  // Abre la galería de imágenes
  Future<void> _openGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  // Redirige al usuario a la configuración de la app para habilitar permisos
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  'Galería de fotos',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Sube fotos de tus proyectos o trabajos realizados para que podamos ver y presumir tu talento.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: 0.80,
                      backgroundColor: Color.fromARGB(255, 124, 204, 250),
                      color: Color.fromARGB(255, 23, 109, 201),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text("80%", style: TextStyle(fontSize: 14)),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add_a_photo),
                  label: const Text("Agregar Imagen"),
                  onPressed: _pickImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _images.isEmpty
                  ? const Center(child: Text('Aún no has agregado imágenes.'))
                  : GridView.builder(
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
                                  backgroundColor: Colors.red,
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
                GestureDetector(
                  onTap: () {
                    // Verifica si el botón está deshabilitado y muestra el SnackBar
                    if (_images.length < 2) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Ingresa al menos 2 imágenes de tu trabajo para continuar')),
                      );
                    }
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _images.length < 2
                          ? null
                          : () {
                              // Acción para continuar
                            },
                      child: const Text(
                        'Continuar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}
