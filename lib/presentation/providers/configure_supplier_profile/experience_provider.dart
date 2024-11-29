import 'package:fixnow/infrastructure/datasources/supplier_data.dart';
import 'package:fixnow/infrastructure/inputs/experience.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

final experienceProvider =
    StateNotifierProvider<ExperienceNotifier, ExperienceState>((ref) {
      final supplierData = ProfileSupplierData();
  return ExperienceNotifier(supplierData: supplierData);
});

class ExperienceState {
  final Experience experience;
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final bool isCompleted;

  const ExperienceState({
    this.experience = const Experience.pure(),
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.isCompleted = false,
  });

  ExperienceState copyWith({
    Experience? experience,
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    bool? isCompleted,
  }) =>
      ExperienceState(
        experience: experience ?? this.experience,
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        isCompleted: isCompleted ?? this.isCompleted,
      );
}

class ExperienceNotifier extends StateNotifier<ExperienceState> {
  final ProfileSupplierData supplierData;
  ExperienceNotifier({required this.supplierData}) : super(const ExperienceState());

  onExperienceChanged(String value) {
    final newExperience = Experience.dirty(value);
    state = state.copyWith(experience: newExperience);
  }

  onFormSubmit(String id) async {
    _touchEveryField();
    if (!state.isValid) return;

    state = state.copyWith(isPosting: true);

    try {
      await supplierData.sendExperience(id, state.experience.value);
      state = state.copyWith(isCompleted: true);
    } catch (e) {
      state = state.copyWith(isPosting: false);
    }
    state = state.copyWith(isPosting: false);
  }

  _touchEveryField() {
    final experience = Experience.dirty(state.experience.value);
    state = state.copyWith(
        isFormPosted: true,
        experience: experience,
        isValid: Formz.validate([experience]));
  }
}
