import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:fixnow/presentation/screens.dart';
import 'package:fixnow/presentation/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  final int pageIndex;
  final List suppliersFound;

  final viewRoutesCustomer = <Widget>[
    const HomeView(),
    const CommunityScreen(),
    const AssistantScreen(),
    const NotificationsScreen(),
    const PrivateCustomerProfile()
  ];

  final viewRoutesSupplier = <Widget>[
    const HomeView(),
    const CommunityScreen(),
    const NotificationsScreen(),
    const FinanceScreen(),
    const PrivateProfileSuplier()
  ];

   HomeScreen({
    super.key,
    required this.pageIndex,
    this.suppliersFound = const [],
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final authState = ref.watch(authProvider);
    return Scaffold(
        backgroundColor: colors.surface,
        drawer: const SideMenu(),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  context.push('/history');
                },
                icon: const Icon(Icons.history))
          ],
          backgroundColor: colors.surface,
        ),
        body: IndexedStack(
          index: pageIndex,
          children: authState.user!.role == 'CUSTOMER'
              ? viewRoutesCustomer
              : viewRoutesSupplier,
        ),
        bottomNavigationBar: CustomBottomNavigation(currentIndex: pageIndex));
  }
}

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final authState = ref.watch(authProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: RefreshIndicator(
        onRefresh: () async {
          // Llamar al método para actualizar los datos
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
      ],
    );
  }
}

class ProvidersSection extends StatelessWidget {
  const ProvidersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            context.push('/supplier/profile');
          },
          child: ProviderCard(
            name: 'Fernando Daniel',
            profession: 'Carpintero',
            price: 350,
            rating: 4,
          ),
        ),
        GestureDetector(
          onTap: () {
            context.push('/supplier/profile');
          },
          child: ProviderCard(
            name: 'Fernando Daniel',
            profession: 'Fontanero',
            price: 350,
            rating: 3,
          ),
        ),
        GestureDetector(
          onTap: () {
            context.push('/supplier/profile');
          },
          child: ProviderCard(
            name: 'Fernando Daniel',
            profession: 'Electricista',
            price: 350,
            rating: 5,
          ),
        ),
      ],
    );
  }
}
