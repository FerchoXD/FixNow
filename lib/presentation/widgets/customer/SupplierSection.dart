import 'package:fixnow/presentation/widgets/customer/SupplierService.dart';
import 'package:flutter/material.dart';

class SuppliersSection extends StatefulWidget {
  const SuppliersSection({super.key});

  @override
  State<SuppliersSection> createState() => _SuppliersSectionState();
}

class _SuppliersSectionState extends State<SuppliersSection> {
  final ServiceSupplier serviceSupplier = ServiceSupplier(); // Instancia del servicio
  List<Map<String, dynamic>> suppliers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSuppliers(); // Llamar a la función para obtener los datos
  }

  Future<void> fetchSuppliers() async {
    setState(() {
      isLoading = true;
    });

    // Llamada al servicio
    final result = await serviceSupplier.fetchSuppliers('data');

    if (result['status'] == 200) {
      setState(() {
        suppliers = List<Map<String, dynamic>>.from(result['data']);
        isLoading = false;
      });
    } else {
      setState(() {
        suppliers = [];
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'Error al cargar proveedores.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : suppliers.isEmpty
            ? const Center(
                child: Text(
                  'No se encontraron proveedores.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            : ListView(
                children: suppliers.map((supplier) {
                  return ProviderCards(
                    name: supplier['fullname'] ?? 'Sin nombre',
                    profession: (supplier['selectedservices'] ?? []).join(', '),
                    phone: supplier['phone'] ?? 'Sin teléfono',
                    email: supplier['email'] ?? 'Sin email',
                    price: supplier['standardprice']?.toDouble() ?? 0.0,
                    rating: supplier['hourlyrate']?.toDouble() ?? 0.0,
                    imageUrl: supplier['image']?['images'] ?? '',
                  );
                }).toList(),
              );
  }
}

class ProviderCards extends StatelessWidget {
  final String name;
  final String profession;
  final String phone;
  final String email;
  final double price;
  final double rating;
  final String imageUrl; // Nueva propiedad para la URL de la imagen

  const ProviderCards({
    super.key,
    required this.name,
    required this.profession,
    required this.phone,
    required this.email,
    required this.price,
    required this.rating,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.person,
                  size: 60,
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '\$$price',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  profession,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Text(
                      rating.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
