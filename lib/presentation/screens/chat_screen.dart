import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Chat',
          style: TextStyle(color: colors.primary),
        )),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: ChatView(),
    );
  }
}

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount:
                1, // Aquí puedes hacer que el número de mensajes sea dinámico
            itemBuilder: (context, index) {
              // Aquí puedes personalizar el diseño de los mensajes
              return const ListTile(
                // title: Text('Message $index'),
                subtitle: Text(
                    'Puedes contactar directamente al proveedor a través de este chat.'),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Escribe aquí...',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colors.primary,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.5)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(113, 48, 48, 48),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15.5)),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(15),
                  backgroundColor: colors.primary,
                ),
                child: const Icon(Icons.send, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
