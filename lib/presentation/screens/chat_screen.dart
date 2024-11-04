import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).size.width / 375;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Chat',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 20 * scaleFactor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Zona de mensajes
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0 * scaleFactor),
              child: Container(
                padding: EdgeInsets.all(12.0 * scaleFactor),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(15 * scaleFactor),
                ),
                child: const Text(
                  'Puedes contactar directamente al proveedor a través de este chat.',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
          ),
          // Zona de escribir mensaje
          Padding(
            padding: EdgeInsets.all(8.0 * scaleFactor),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Escribe aquí...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15 * scaleFactor),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8 * scaleFactor),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: () {
                    // Aquí puedes manejar el envío del mensaje
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      // Barra de navegación
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Cambia el índice según la pestaña actual
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: 'Comunidad',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble, color: Colors.blue),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
