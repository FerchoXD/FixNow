import 'package:dio/dio.dart';
import 'package:fixnow/config/config.dart';
import 'package:fixnow/domain/entities/supplier.dart';
import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:fixnow/presentation/screens.dart';
import 'package:fixnow/presentation/widgets.dart';
import 'package:fixnow/presentation/widgets/customer/SupplierSection.dart';
import 'package:fixnow/presentation/widgets/customer/SupplierService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  final int pageIndex;
  final List suppliersFound;

  const HomeScreen({
    super.key,
    required this.pageIndex,
    this.suppliersFound = const [],
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final authState = ref.watch(authProvider);

    if (kDebugMode) {
      print("suppliers desde HomeScreen: $suppliersFound");
    }

    final viewRoutesCustomer = <Widget>[
      HomeView(suppliersFound: suppliersFound),
      const CommunityScreen(),
      const AssistantScreen(),
      const NotificationsScreen(),
      const PrivateCustomerProfile(),
    ];

    final viewRoutesSupplier = <Widget>[
      HomeView(suppliersFound: suppliersFound),
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
  final List<dynamic> suppliersFound;

  const HomeView({super.key, required this.suppliersFound});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final authState = ref.watch(authProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: RefreshIndicator(
        onRefresh: () async {
          await _refreshData(ref);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(), // Permite el gesto "pull-to-refresh" incluso si el contenido no es suficiente para scroll
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
                        color: colors.onSurface),
                  ),
                  Text(
                    authState.user!.name,
                    style:
                        TextStyle(fontSize: 18, color: colors.onSurfaceVariant),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: "Buscar...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              if (suppliersFound.isNotEmpty) ...[
                const SizedBox(height: 30),
                Text(
                  'Ellos prodran ayudarte',
                  style:
                      TextStyle(fontSize: 16, color: colors.onSurfaceVariant),
                ),
                const SizedBox(height: 20),
                ProvidersSection(suppliersFound: suppliersFound),
              ] else ...[
                const SizedBox(height: 30),
                Text(
                  'Servicios',
                  style:
                      TextStyle(fontSize: 16, color: colors.onSurfaceVariant),
                ),
                const SizedBox(height: 20),
                const ServicesSection(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refreshData(WidgetRef ref) async {

    print("Datos actualizados");
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
        const SizedBox(height: 20),
        const Text(
          'Proveedores destacados',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),

        FutureBuilder(
  future: fetchSuppliers(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(
        child: Text('Error: ${snapshot.error}'),
      );
    } else if (snapshot.data!.isEmpty) {
      return const Center(
        child: Text('No se encontraron proveedores destacados.'),
      );
    } else {
      final suppliers = snapshot.data as List<Map<String, dynamic>>;
      return ListView.builder(
        shrinkWrap: true,
        itemCount: suppliers.length,
        itemBuilder: (context, index) {
          final supplier = suppliers[index];
          return ProviderCard(
            name: supplier['fullname'],
            profession: (supplier['selectedservices'] ?? []).join(', '),
            imageUrl: supplier['image']['images'],
            rating: supplier['relevance']?.toDouble() ?? 0.0,
            price: supplier['standardprice']?.toDouble() ?? 0.0,
            price2: supplier['hourlyrate']?.toDouble() ?? 0.0,
          );
        },
      );
    }
  },
)

      ],
    );
  }

  Future<List<Map<String, dynamic>>> fetchSuppliers() async {
    final service = ServiceSupplier();
    final result = await service.fetchSuppliers('Electricidad');

    if (result['status'] == 200) {
      return List<Map<String, dynamic>>.from(result['data']);
    } else {
      print('Error: ${result['message']}');
      throw Exception(result['message']);
    }
  }
}

class ProviderCard extends StatelessWidget {
  final String name;
  final String profession;
  final String imageUrl;
  final double rating;
  final double price;
  final double price2;

  const ProviderCard({
    super.key,
    required this.name,
    required this.profession,
    required this.imageUrl,
    required this.rating,
    required this.price,
    required this.price2,
  });

  @override
  Widget build(BuildContext context) {
    print("imageUrl: $imageUrl");
    print("name: $name");
    print("profession: $profession");
    print("rating: $rating");
    print("price: $price");

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
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
                return const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.grey,
                );
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  profession,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              Text(
                price != null && price != 0 // Si `price` no es nulo ni cero
                    ? '\$$price'
                    : price2 != null && price2 != 0 // Si `price2` no es nulo ni cero
                        ? '\$$price2'
                        : 'Negociable',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow, size: 16),
                  Text(rating == 0 ? 'Nuevo' : rating.toStringAsFixed(1)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProvidersSection extends StatelessWidget {
  final List<dynamic> suppliersFound;

  const ProvidersSection({super.key, required this.suppliersFound});

  @override
  Widget build(BuildContext context) {
    for (var element in suppliersFound) {
      if (kDebugMode) {
        print("suppliers desde found equisde{$element['fullname']}");
      }
    }

    if (suppliersFound.isEmpty) {
      return const Center(
        child: Text('No se encontraron proveedores.'),
      );
    }

    return Column(
      children: suppliersFound.map((supplier) {
        if (kDebugMode) {
          print("suppliers desde found equisde{$supplier['fullname']}");
        }
        return GestureDetector(
          onTap: () {
            context.push('/supplier/profile', extra: supplier);
          },
          child: ProviderCard(
            name: supplier['fullname'] ?? 'Desconocido',
            profession:
                supplier['selectedservices']?.join(', ') ?? 'Sin profesión',
            imageUrl: supplier['image']['images'] ?? '',
            price: supplier['hourlyrate'],
            price2: supplier['standardprice'] ?? 0,
            rating: supplier['relevance'] ?? 0,
          ),
        );
      }).toList(),
    );
  }
}
