import 'package:fixnow/presentation/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.light_mode_rounded)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
        ],
      ),
      body: HomeView(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GNav(
            tabActiveBorder: Border.all(color: Colors.black, width: 0.1),
            gap: 8,
            activeColor: colors.primary,
            color: colors.secondary,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Inicio',
              ),
              GButton(
                icon: Icons.comment,
                text: 'Comunidad',
              ),
              GButton(
                icon: Icons.assistant,
                text: 'Asistente',
              ),
              GButton(
                icon: Icons.person,
                text: 'Perfil',
              )
            ]),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Hola, ",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colors.secondary),
              ),
              Text(
                "Alan Gómez",
                style: TextStyle(fontSize: 18, color: colors.secondary),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Buscar...",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text('Servicios'),
          const SizedBox(
            height: 30,
          ),
          ServicesSection(),
          ProvidersSection(),
        ],
      ),
    );
  }
}

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              ServiceCard(
                  iconPath: 'assets/images/plomeria.png', label: 'Plomería'),
              ServiceCard(
                  iconPath: 'assets/images/carpinteria.png',
                  label: 'Carpintería'),
              ServiceCard(
                  iconPath: 'assets/images/electricidad.png',
                  label: 'Electricidad'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            label: const Text('Filtrar'),
            onPressed: () {
              // Acción del botón de filtro
            },
            icon: const Icon(Icons.filter_list),
          ),
        ),
      ],
    );
  }
}

class ProvidersSection extends StatelessWidget {
  const ProvidersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ProviderCard(
          name: 'Fernando Daniel',
          profession: 'Carpintero',
          price: 350,
          rating: 4,
        ),
        ProviderCard(
          name: 'Fernando Daniel',
          profession: 'Fontanero',
          price: 350,
          rating: 3,
        ),
        ProviderCard(
          name: 'Fernando Daniel',
          profession: 'Electricista',
          price: 350,
          rating: 5,
        ),
      ],
    );
  }
}
