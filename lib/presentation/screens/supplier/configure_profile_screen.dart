import 'package:fixnow/presentation/providers/configure_supplier_profile/information_provider.dart';
import 'package:fixnow/presentation/widgets/configure_supplier_profile/basic_information.dart';
import 'package:fixnow/presentation/widgets/configure_supplier_profile/category_services.dart';
import 'package:fixnow/presentation/widgets/configure_supplier_profile/completed_profile.dart';
import 'package:fixnow/presentation/widgets/configure_supplier_profile/photo_gallery.dart';
import 'package:fixnow/presentation/widgets/configure_supplier_profile/rates_prices.dart';
import 'package:fixnow/presentation/widgets/configure_supplier_profile/time_availability.dart';
import 'package:fixnow/presentation/widgets/configure_supplier_profile/work_experience.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ConfigureProfileScreen extends ConsumerWidget {
  const ConfigureProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final informationState = ref.watch(informationProvider);
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Color(colors.surface.value),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InstructionsView(
                section: informationState.section,
              ),
              const SizedBox(
                height: 20,
              ),
              const ProgressView(),
              const SizedBox(
                height: 20,
              ),
              const FormView(),
            ],
          ),
        ),
      ),
    );
  }
}

class FormView extends ConsumerWidget {
  const FormView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final informationState = ref.watch(informationProvider);
    return SingleChildScrollView(
      child: Form(
        
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child:renderView(informationState.section),
        ),
      ),
    );
  }

  renderView(int section) {
    switch (section) {
      case 0:
        return const BasicInformation();
      case 1:
        return const ServiceCategories();
      case 2:
        return const WorkExperience();
      case 3:
        return const RatesPrices();
      case 4:
        return const TimeAvailability();
      case 5:
        return const PhotoGallery();
      case 6:
        return const CompletedProfile();
    }
  }
}

class InstructionsView extends ConsumerWidget {
  final int section;
  const InstructionsView({super.key, required this.section});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    final sections = {
      0: {
        'title': 'Información básica',
        'instructions':
            'Completa los campos para que los clientes puedan conocerte y contactarte fácilmente.',
      },
      1: {
        'title': 'Categoría de servicios',
        'instructions': 'Selecciona las áreas en donde te especializas.',
      },
      2: {
        'title': 'Experiencia laboral',
        'instructions':
            'Cuéntanos un poco sobre tu experiencia, por ejemplo, trabajos anteriores, tipos de proyectos realizados, habilidades destacadas.',
      },
      3: {
        'title': 'Tarifas y precios',
        'instructions':
            'Establece un precio estándar o por hora para que los clientes conozcan tus costos antes de contratarte.',
      },
      4: {
        'title': 'Configura tu horario',
        'instructions':
            'Selecciona los días y horas en los que estarás disponible para recibir solicitudes de servicio.',
      },
      5: {
        'title': 'Galería de fotos',
        'instructions': 'Agrega algunas imágenes referentes a tus habilidades.',
      },
      6: {
        'title': 'Perfil completado',
        'instructions': 'Has completado la configuración de tu perfil.',
      },
    };

    final sectionData = sections[section] ??
        {
          'title': 'Sección desconocida',
          'instructions': 'No hay información para esta sección.',
        };

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          sectionData['title']!,
          style: TextStyle(
              color: colors.primary, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            sectionData['instructions']!,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class ProgressView extends ConsumerWidget {
  const ProgressView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    final informationState = ref.watch(informationProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        LinearPercentIndicator(
          animation: true,
          animateFromLastPercent: true,
          animationDuration: 1000,
          lineHeight: 6,
          percent: informationState.loadingBar,
          progressColor: Color(colors.primary.value),
          backgroundColor: Color(colors.primary.withOpacity(0.3).value),
          barRadius: const Radius.circular(10),
          trailing: Text(
            '${informationState.percentageCompleted}%',
            style: TextStyle(
                color: Color(colors.primary.value),
                fontWeight: FontWeight.w700),
          ),
        )
      ],
    );
  }
}
