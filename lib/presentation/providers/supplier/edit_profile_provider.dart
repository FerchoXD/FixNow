import 'package:fixnow/domain/entities/user.dart';
import 'package:fixnow/infrastructure/inputs/hourly_rate.dart';
import 'package:fixnow/infrastructure/inputs/standar_price.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final editProfileProvider = StateNotifierProvider.family
    .autoDispose<EditProfileNotifier, EditProfileState, User>((ref, user) {
  return EditProfileNotifier(user: user);
});

class EditProfileState {
  final String id;
  final User user;
  final bool isLoading;
  final List<String> services;
  final String experience;
  final double standarPrice;
  final double hourlyRate;

  const EditProfileState(
      {this.id = '',
      required this.user,
      this.isLoading = true,
      this.services = const [],
      this.experience = '',
      this.standarPrice = 0.0,
      this.hourlyRate = 0.0});

  EditProfileState copyWith({
    String? id,
    User? user,
    bool? isLoading,
    List<String>? services,
    String? experience,
    double? standarPrice,
    double? hourlyRate,
  }) =>
      EditProfileState(
        id: id ?? this.id,
        user: user ?? this.user,
        isLoading: isLoading ?? this.isLoading,
        services: services ?? this.services,
        experience: experience ?? this.experience,
        standarPrice: standarPrice ?? this.standarPrice,
        hourlyRate: hourlyRate ?? this.hourlyRate,
      );
}

class EditProfileNotifier extends StateNotifier<EditProfileState> {
  EditProfileNotifier({required User user})
      : super(EditProfileState(user: user));

  onServicesSelected(List<String> services) {
    print(state.user);
    state = state.copyWith(services: services);
  }

  onExperienceChanged(String value) {
    state = state.copyWith(experience: value);
  }

  onStandarPriceChanged(double value) {
    
  }

}
