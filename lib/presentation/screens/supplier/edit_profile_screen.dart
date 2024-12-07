import 'package:fixnow/domain/entities/user.dart';
import 'package:fixnow/presentation/providers/auth/auth_provider.dart';
import 'package:fixnow/presentation/providers/supplier/edit_profile_provider.dart';
import 'package:fixnow/presentation/widgets/configure_supplier_profile/time_availability.dart';
import 'package:fixnow/presentation/widgets/custom_text_fiel.dart';
import 'package:fixnow/presentation/widgets/supplier/edit_photos.dart';
import 'package:fixnow/presentation/widgets/supplier/edit_time_availability.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(authProvider);
    final userEdit = ref.watch(editProfileProvider(userState.user!));
    return Scaffold(
      appBar: AppBar(),
      body: EditProfileView(
        user: userEdit.user,
      ),
    );
  }
}

class EditProfileView extends ConsumerWidget {
  final User user;
  const EditProfileView({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Imagenes',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: colors.onSurface),
            ),
            const SizedBox(
              height: 20,
            ),
            EditPhotoGallery(
              profileImages: user.profileImages!,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Servicios',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: colors.onSurface),
            ),
            const SizedBox(
              height: 20,
            ),
            EditServices(
              user: user,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Experiencia',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: colors.onSurface),
            ),
            const SizedBox(
              height: 20,
            ),
            EditExperience(
              user: user,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Precios y tarifas',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: colors.onSurface),
            ),
            const SizedBox(
              height: 20,
            ),
            EditPrices(
              user: user,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Disponibilidad horaria',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: colors.onSurface),
            ),
            const SizedBox(
              height: 20,
            ),
            EditTimeAvailability(
              user: user,
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class EditPhotos extends StatelessWidget {
  const EditPhotos({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class EditServices extends ConsumerStatefulWidget {
  final User user;
  const EditServices({super.key, required this.user});

  @override
  EditServiceCategoriesState createState() => EditServiceCategoriesState();
}

class EditServiceCategoriesState extends ConsumerState<EditServices> {
  final List<String> categories = [
    "Plomería",
    "Electricidad",
    "Carpintería",
    "Pintura",
    "Limpieza general",
    "Jardinería",
    "Albañilería",
    "Cerrajería",
    "Electrodomésticos",
    "Climatización",
    "Impermeabilización",
  ];

  late Set<String> selectedCategories;

  @override
  void initState() {
    super.initState();

    selectedCategories = widget.user.selectedServices?.toSet() ?? {};
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

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

                ref
                    .read(editProfileProvider(widget.user).notifier)
                    .onServicesSelected(selectedCategories.toList());
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
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}

class EditExperience extends ConsumerWidget {
  final User user;
  const EditExperience({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        CustomTextField(
          label: 'Experiencia',
          maxLines: 8,
          initialValue: user.workExperience,
        )
      ],
    );
  }
}

class EditPrices extends ConsumerWidget {
  final User user;
  const EditPrices({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        CustomTextField(
          label: 'Precio estandar',
          initialValue: user.standardPrice.toString(),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
          label: 'Precio por hora',
          initialValue: user.hourlyRate.toString(),
        )
      ],
    );
  }
}

class EditSchedule extends ConsumerWidget {
  final User user;
  const EditSchedule({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Placeholder();
  }
}
