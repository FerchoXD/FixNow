import 'package:fixnow/presentation/providers/configure_supplier_profile/basic_info_provider.dart';
import 'package:fixnow/presentation/providers/configure_supplier_profile/experience_provider.dart';
import 'package:fixnow/presentation/providers/configure_supplier_profile/prices_provider.dart';
import 'package:fixnow/presentation/providers/configure_supplier_profile/services_provider.dart';
import 'package:fixnow/presentation/providers/configure_supplier_profile/time_availability_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum FormStatus { checking, completed, notCompleted }

class InformationState {
  final FormStatus formStatus;
  final int section;
  final double loadingBar;
  final int percentageCompleted;
  final int savedProgress;

  InformationState(
      {this.formStatus = FormStatus.checking,
      this.section = 0,
      this.loadingBar = 0.0,
      this.percentageCompleted = 0,
      this.savedProgress = 0});

  InformationState copyWith({
    FormStatus? formStatus,
    int? section,
    double? loadingBar,
    int? percentageCompleted,
    int? savedProgress,
  }) =>
      InformationState(
        formStatus: formStatus ?? this.formStatus,
        section: section ?? this.section,
        loadingBar: loadingBar ?? this.loadingBar,
        percentageCompleted: percentageCompleted ?? this.percentageCompleted,
        savedProgress: savedProgress ?? this.savedProgress,
      );
}

class InformationNotifier extends StateNotifier<InformationState> {
  InformationNotifier() : super(InformationState());

  continueProgress() async {
    state = state.copyWith(section: state.savedProgress + 1);
    final percentage = calcPercentage();
    state = state.copyWith(
        loadingBar: percentage / 100, percentageCompleted: percentage);
  }

  changeSection() {
    print('Cambiando la seccion');
    state = state.copyWith(section: state.section + 1);
    final percentage = calcPercentage();
    state = state.copyWith(
        loadingBar: percentage / 100, percentageCompleted: percentage);
        print(state.section);
  }

  formCompleted() {
    state = state.copyWith(
        formStatus: FormStatus.completed,
        loadingBar: 1,
        percentageCompleted: 100);
  }

  calcPercentage() {
    switch (state.section) {
      case 0:
        return 0;
      case 1:
        return 20;
      case 2:
        return 40;
      case 3:
        return 60;
      case 4:
        return 80;
      case 5:
        return 100;
    }
  }
}

final informationProvider =
    StateNotifierProvider<InformationNotifier, InformationState>((ref) {
  final informationNotifier = InformationNotifier();

  ref.listen(providerBasicInfo, (previous, next) {
    if (next) {
      informationNotifier.changeSection();
    }
  });

  ref.listen(providerServicesInfo, (previous, next) {
    if (next) {
      informationNotifier.changeSection();
    }
  });

  ref.listen(providerExperienceInfo, (previous, next) {
    if (next) {
      informationNotifier.changeSection();
    }
  });

  ref.listen(providerPricesInfo, (previous, next) {
    if (next) {
      informationNotifier.changeSection();
    }
  });

  ref.listen(providerTimeInfo, (previous, next) {
    if (next) {
      informationNotifier.changeSection();
    }
  });

  return informationNotifier;
});

final providerBasicInfo = Provider<bool>((ref) {
  final infoData = ref.watch(basicInfoProvider);
  return infoData.isCompleted;
});

final providerServicesInfo = Provider<bool>((ref) {
  final infoData = ref.watch(servicesProvider);
  return infoData.isCompleted;
});

final providerExperienceInfo = Provider<bool>((ref) {
  final infoData = ref.watch(experienceProvider);
  return infoData.isCompleted;
});

final providerPricesInfo = Provider<bool>((ref) {
  final infoData = ref.watch(pricesProvider);
  return infoData.isCompleted;
});

final providerTimeInfo = Provider<bool>((ref) {
  final infoData = ref.watch(timeProvider);
  return infoData.isCompleted;
});
