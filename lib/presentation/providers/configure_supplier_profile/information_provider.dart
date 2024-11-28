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
      this.section = 3,
      this.loadingBar = 0.0,
      this.percentageCompleted = 0,
      this.savedProgress = 0,});

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
          savedProgress: savedProgress ?? this.savedProgress,);
}

class InformationNotifier extends StateNotifier<InformationState> {
  // final FormStudent formStudent;
  // final AuthState userData;
  InformationNotifier() : super(InformationState());

  // getNumberSection(String section) {
  //   switch (section) {
  //     case 'none':
  //       return 0;
  //     case 'alumno':
  //       return 2;
  //     case 'contacto':
  //       return 3;
  //     case 'datos_medicos':
  //       return 4;
  //     case 'datos_academicos':
  //       return 5;
  //     case 'datos_socioeconomicos':
  //       return 6;
  //     case 'imagen':
  //       return 7;
  //   }
  // }

  continueProgress() async {
    state = state.copyWith(section: state.savedProgress + 1);
    final percentage = calcPercentage();
    state = state.copyWith(
        loadingBar: percentage / 100, percentageCompleted: percentage);
  }

  changeSection() {
    state = state.copyWith(section: state.section + 1);
    final percentage = calcPercentage();
    state = state.copyWith(
        loadingBar: percentage / 100, percentageCompleted: percentage);
  }

  formCompleted() {
    state = state.copyWith(
        formStatus: FormStatus.completed,
        loadingBar: 1,
        percentageCompleted: 100);
  }

  calcPercentage() {
    switch (state.section) {
      case 1:
        return 0;
      case 2:
        return 20;
      case 3:
        return 40;
      case 4:
        return 50;
      case 5:
        return 70;
      case 6:
        return 80;
      case 7:
        return 90;
      case 8:
        return 100;
      default:
    }
  }

}

final informationProvider = StateNotifierProvider<InformationNotifier, InformationState>((ref) {
  return InformationNotifier();
 });
//   final accessToken = ref.watch(authProvider).user?.token ?? '';
//   final formStudent = FormStudent(accessToken: accessToken);
//   final userData = ref.watch(authProvider);

//   final formNotifier =
//       InformationNotifier(formStudent: formStudent, userData: userData);

//   ref.listen(codeStatusProvider, (previous, next) {
//     if (next == CodeStatus.valid) {
//       formNotifier.continueProgress();
//     }
//   });

//   ref.listen(firstSectionStateProvider, (previous, next) {
//     if (next) {
//       formNotifier.changeSection();
//     }
//   });

//   ref.listen(secondSectionStateProvider, (previous, next) {
//     if (next) {
//       formNotifier.changeSection();
//     }
//   });

//   ref.listen(contactStateProvider, (previous, next) {
//     if (next) {
//       formNotifier.changeSection();
//     }
//   });

//   ref.listen(medicalSectionStateProvider, (previous, next) {
//     if (next) {
//       formNotifier.changeSection();
//     }
//   });

//   ref.listen(academicSectionStateProvider, (previous, next) {
//     if (next) {
//       formNotifier.changeSection();
//     }
//   });

//   ref.listen(socioEconomicSectionStateProvider, (previous, next) {
//     if (next) {
//       formNotifier.changeSection();
//     }
//   });

//   ref.listen(photoSectionProvider, (previous, next) {
//     if (next) {
//       formNotifier.changeSection();
//     }
//   });

//   return formNotifier;
// });

// final codeStatusProvider = Provider<CodeStatus>((ref) {
//   final codeStatus = ref.watch(codeProvider);
//   return codeStatus.codeStatus;
// });

// final firstSectionStateProvider = Provider<bool>((ref) {
//   final firstSectionState = ref.watch(firstStudentDataProvider);
//   return firstSectionState.isValid;
// });

// final secondSectionStateProvider = Provider<bool>((ref) {
//   final secondSectionState = ref.watch(secondStudentDataProvider);
//   return secondSectionState.isCompleted;
// });

// final contactStateProvider = Provider<bool>((ref) {
//   final contactData = ref.watch(contactDataProvider);
//   return contactData.isCompleted;
// });

// final medicalSectionStateProvider = Provider<bool>((ref) {
//   final medicalData = ref.watch(medicalDataProvider);
//   return medicalData.isCompleted;
// });

// final academicSectionStateProvider = Provider<bool>((ref) {
//   final academicData = ref.watch(academicDataProvider);
//   return academicData.isCompleted;
// });

// final socioEconomicSectionStateProvider = Provider<bool>((ref) {
//   final socioeconomicData = ref.watch(socioeconomicDataProvider);
//   return socioeconomicData.isCompleted;
// });

// final photoSectionProvider = Provider<bool>((ref) {
//   final photoData = ref.watch(photoProvider);
//   return photoData.isCompleted;
// });