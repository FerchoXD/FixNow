import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:fixnow/presentation/providers/home/home_provider.dart';
import 'package:fixnow/presentation/screens.dart';
import 'package:fixnow/presentation/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  final int pageIndex;

  const HomeScreen({
    super.key,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final authState = ref.watch(authProvider);

    final viewRoutesCustomer = <Widget>[
      const HomeView(),
      const CommunityScreen(),
      const AssistantScreen(),
      const NotificationsScreen(),
      const PrivateCustomerProfile(),
    ];

    final viewRoutesSupplier = <Widget>[
      const HomeView(),
      const CommunityScreen(),
      const AssistantScreen(),
      const NotificationsScreen(),
      const PrivateProfileSuplier(),
    ];

    return Scaffold(
      backgroundColor: colors.surface,
      drawer: const SideMenu(),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.push('/history');
            },
            icon: const Icon(Icons.history),
          )
        ],
        backgroundColor: colors.surface,
      ),
      body: IndexedStack(
        index: pageIndex,
        children: authState.user!.role == 'CUSTOMER'
            ? viewRoutesCustomer
            : viewRoutesSupplier,
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: pageIndex),
    );
  }
}

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final authState = ref.watch(authProvider);
    final homeState = ref.watch(homeProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: homeState.isLoading
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Hola, ",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: colors.onSurface),
                      ),
                      Text(
                        authState.user!.name,
                        style: TextStyle(
                            fontSize: 24, color: colors.onSurfaceVariant),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const SearchSectionHome(),
                  const SizedBox(height: 30),
                  const ServicesSection(),
                  const SizedBox(height: 30),
                  Text(
                    'Proveedores',
                    style:
                        TextStyle(fontSize: 16, color: colors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 10),
                  const SupplierSection()
                ],
              ),
            ),
    );
  }
}

class SearchSectionHome extends StatelessWidget {
  const SearchSectionHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            offset: const Offset(4, 4),
            spreadRadius: 1,
          ),
        ],
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Buscar...",
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: colors.primaryContainer,
        ),
      ),
    );
  }
}

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Servicios",
          style: TextStyle(fontSize: 16, color: colors.onSurfaceVariant),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ServiceCard(
                iconService: Icon(Icons.water_drop,
                    size: 60, color: colors.primary.withOpacity(0.8)),
                label: 'Plomería',
              ),
              ServiceCard(
                iconService: Icon(Icons.electric_bolt_outlined,
                    size: 60, color: colors.primary.withOpacity(0.8)),
                label: 'Electricidad',
              ),
              ServiceCard(
                iconService: Icon(Icons.handyman,
                    size: 60, color: colors.primary.withOpacity(0.8)),
                label: 'Carpintería',
              ),
              ServiceCard(
                iconService: Icon(Icons.format_paint,
                    size: 60, color: colors.primary.withOpacity(0.8)),
                label: 'Pintura',
              ),
              ServiceCard(
                iconService: Icon(Icons.grass,
                    size: 60, color: colors.primary.withOpacity(0.8)),
                label: 'Jardinería',
              ),
              ServiceCard(
                iconService: Icon(Icons.build,
                    size: 60, color: colors.primary.withOpacity(0.8)),
                label: 'Albañilería',
              ),
              ServiceCard(
                iconService: Icon(Icons.lock,
                    size: 60, color: colors.primary.withOpacity(0.8)),
                label: 'Cerrajería',
              ),
              ServiceCard(
                iconService: Icon(Icons.cleaning_services,
                    size: 60, color: colors.primary.withOpacity(0.8)),
                label: 'Limpieza general',
              ),
              ServiceCard(
                iconService: Icon(Icons.devices,
                    size: 60, color: colors.primary.withOpacity(0.8)),
                label: 'Electrodomésticos',
              ),
              ServiceCard(
                iconService: Icon(Icons.ac_unit,
                    size: 60, color: colors.primary.withOpacity(0.8)),
                label: 'Climatización',
              ),
              ServiceCard(
                iconService: Icon(Icons.water_damage,
                    size: 60, color: colors.primary.withOpacity(0.8)),
                label: 'Impermeabilización',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SupplierSection extends ConsumerWidget {
  const SupplierSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: homeState.suppliers.length,
      itemBuilder: (context, index) {
        final supplier = homeState.suppliers[index];
        return GestureDetector(
          onTap: () => context.push('/supplier/${supplier.uuid}'),
          child: SupplierCard(
            name: supplier.firstname,
            profession: supplier.selectedServices.first,
            imageUrl: supplier.images.first,
            rating: supplier.relevance,
            price: supplier.standardPrice,
          ),
        );
      },
    );
  }
}

class SupplierCard extends StatelessWidget {
  final String name;
  final String profession;
  final String imageUrl;
  final double rating;
  final double price;

  const SupplierCard({
    super.key,
    required this.name,
    required this.profession,
    required this.imageUrl,
    required this.rating,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            offset: const Offset(4, 4),
            spreadRadius: 1,
          ),
        ],
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Imagen del proveedor
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.person,
                    size: 50, color: colors.primary.withOpacity(0.7));
              },
            ),
          ),
          const SizedBox(width: 10),
          
          // Información principal del proveedor
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: colors.onSurface),
                ),
                Text(
                  profession,
                  style: TextStyle(color: colors.onSurfaceVariant),
                ),
                const SizedBox(height: 4),
                // Rating con íconos de estrellas
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rating.toStringAsFixed(1),  // Mostrar rating con un decimal
                      style: TextStyle(color: colors.onSurfaceVariant),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),

          // Precio alineado a la derecha
          Text(
            '\$${price.toStringAsFixed(2)}',  // Mostrar precio con dos decimales
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
