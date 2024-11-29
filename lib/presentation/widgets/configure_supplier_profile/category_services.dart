import 'package:fixnow/presentation/providers.dart';
import 'package:fixnow/presentation/providers/configure_supplier_profile/services_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceCategories extends ConsumerStatefulWidget {
  const ServiceCategories({super.key});

  @override
  ServiceCategoriesState createState() => ServiceCategoriesState();
}

class ServiceCategoriesState extends ConsumerState<ServiceCategories> {
  final List<String> categories = [
    'Plomería',
    'Electricidad',
    'Carpintería',
    'Pintura',
    'Limpieza general',
    'Jardinería',
    'Albañilería',
    'Fontanería',
    'Cerrajería',
    'Electrodomésticos',
    'Aires acondicionados',
    'Techo y filtraciones',
  ];

  final Set<String> selectedCategories = {};

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final authState = ref.watch(authProvider);
    return Column(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: categories.map((category) {
            final isSelected = selectedCategories.contains(category);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    selectedCategories.remove(category);
                  } else {
                    selectedCategories.add(category);
                  }
                });

                ref.read(servicesProvider.notifier).onServicesSelected(selectedCategories.toList());
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? colors.primary : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 30,),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              onPressed:  () {
                ref.read(servicesProvider.notifier).onFormSubmit(authState.userTemp!.uuid);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 17),
                child: Text(
                  'Continuar',
                  style: TextStyle(color: Colors.white),
                ),
              )),
        ),
      ],
    );
  }
}
