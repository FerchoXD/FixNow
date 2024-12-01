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
      child: SingleChildScrollView(
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
                  authState.user != null ? authState.user!.name! : '',
                  style:
                      TextStyle(fontSize: 24, color: colors.onSurfaceVariant),
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
              style: TextStyle(fontSize: 16, color: colors.onSurfaceVariant),
            ),
            const SizedBox(height: 10),
            homeState.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const SupplierSection()
          ],
        ),
      ),
    );
  }
}

class SearchSectionHome extends ConsumerWidget {
  const SearchSectionHome({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      child: TextFormField(
        onChanged: ref.read(homeProvider.notifier).onSearchValueChanged,
        onFieldSubmitted: (value) {
          ref.read(homeProvider.notifier).searchSuppliers();
        },
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

class ServicesSection extends ConsumerWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final selectedServices = ref.watch(selectedServiceProvider);
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
              GestureDetector(
                onTap: () {
                  ref
                      .read(selectedServiceProvider.notifier)
                      .update((state) => 'Plomería');
                  ref
                      .read(homeProvider.notifier)
                      .getServiceByCategory('Plomería');
                },
                child: ServiceCard(
                  isSelected: selectedServices == 'Plomería',
                  iconService: Icons.water_drop,
                  label: 'Plomería',
                ),
              ),
              GestureDetector(
                onTap: () {
                  ref
                      .read(selectedServiceProvider.notifier)
                      .update((state) => 'Electricidad');
                  ref
                      .read(homeProvider.notifier)
                      .getServiceByCategory('Electricidad');
                },
                child: ServiceCard(
                  isSelected: selectedServices == 'Electricidad',
                  iconService: Icons.electric_bolt_outlined,
                  label: 'Electricidad',
                ),
              ),
              GestureDetector(
                onTap: () {
                  ref
                      .read(selectedServiceProvider.notifier)
                      .update((state) => 'Carpintería');
                  ref
                      .read(homeProvider.notifier)
                      .getServiceByCategory('Carpintería');
                },
                child: ServiceCard(
                  isSelected: selectedServices == 'Carpintería',
                  iconService: Icons.handyman,
                  label: 'Carpintería',
                ),
              ),
              GestureDetector(
                onTap: () {
                  ref
                      .read(selectedServiceProvider.notifier)
                      .update((state) => 'Pintura');
                  ref
                      .read(homeProvider.notifier)
                      .getServiceByCategory('Pintura');
                },
                child: ServiceCard(
                  isSelected: selectedServices == 'Pintura',
                  iconService: Icons.format_paint,
                  label: 'Pintura',
                ),
              ),
              GestureDetector(
                onTap: () {
                  ref
                      .read(selectedServiceProvider.notifier)
                      .update((state) => 'Jardinería');
                  ref
                      .read(homeProvider.notifier)
                      .getServiceByCategory('Jardinería');
                },
                child: ServiceCard(
                  isSelected: selectedServices == 'Jardinería',
                  iconService: Icons.grass,
                  label: 'Jardinería',
                ),
              ),
              GestureDetector(
                onTap: () {
                  ref
                      .read(selectedServiceProvider.notifier)
                      .update((state) => 'Albañilería');
                  ref
                      .read(homeProvider.notifier)
                      .getServiceByCategory('Albañilería');
                },
                child: ServiceCard(
                  isSelected: selectedServices == 'Albañilería',
                  iconService: Icons.build,
                  label: 'Albañilería',
                ),
              ),
              GestureDetector(
                onTap: () {
                  ref
                      .read(selectedServiceProvider.notifier)
                      .update((state) => 'Cerrajería');
                  ref
                      .read(homeProvider.notifier)
                      .getServiceByCategory('Cerrajería');
                },
                child: ServiceCard(
                  isSelected: selectedServices == 'Cerrajería',
                  iconService: Icons.lock,
                  label: 'Cerrajería',
                ),
              ),
              GestureDetector(
                onTap: () {
                  ref
                      .read(selectedServiceProvider.notifier)
                      .update((state) => 'Limpieza general');
                  ref
                      .read(homeProvider.notifier)
                      .getServiceByCategory('Limpieza general');
                },
                child: ServiceCard(
                  isSelected: selectedServices == 'Limpieza general',
                  iconService: Icons.cleaning_services,
                  label: 'Limpieza general',
                ),
              ),
              GestureDetector(
                onTap: () {
                  ref
                      .read(selectedServiceProvider.notifier)
                      .update((state) => 'Electrodomésticos');
                  ref
                      .read(homeProvider.notifier)
                      .getServiceByCategory('Electrodomésticos');
                },
                child: ServiceCard(
                  isSelected: selectedServices == 'Electrodomésticos',
                  iconService: Icons.devices,
                  label: 'Electrodomésticos',
                ),
              ),
              GestureDetector(
                onTap: () {
                  ref
                      .read(selectedServiceProvider.notifier)
                      .update((state) => 'Climatización');
                  ref
                      .read(homeProvider.notifier)
                      .getServiceByCategory('Climatización');
                },
                child: ServiceCard(
                  isSelected: selectedServices == 'Climatización',
                  iconService: Icons.ac_unit,
                  label: 'Climatización',
                ),
              ),
              GestureDetector(
                onTap: () {
                  ref
                      .read(selectedServiceProvider.notifier)
                      .update((state) => 'Impermeabilización');
                  ref
                      .read(homeProvider.notifier)
                      .getServiceByCategory('Impermeabilización');
                },
                child: ServiceCard(
                  isSelected: selectedServices == 'Impermeabilización',
                  iconService: Icons.water_damage,
                  label: 'Impermeabilización',
                ),
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
    return homeState.suppliers.isEmpty
        ? const Padding(
            padding: EdgeInsets.symmetric(vertical: 150),
            child: Center(
              child: Text('No se encontraron proveedores'),
            ),
          )
        : ListView.builder(
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
                  imageUrl:
                      supplier.images != null && supplier.images!.isNotEmpty
                          ? supplier.images!.first
                          : 'https://www.example.com',
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
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rating
                          .toStringAsFixed(1), // Mostrar rating con un decimal
                      style: TextStyle(color: colors.onSurfaceVariant),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '\$${price.toStringAsFixed(2)}', // Mostrar precio con dos decimales
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
