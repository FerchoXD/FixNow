import 'package:fixnow/infrastructure/datasources/supplier_data.dart';
import 'package:fixnow/infrastructure/inputs.dart';
import 'package:fixnow/infrastructure/inputs/location.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

final basicInfoProvider = StateNotifierProvider<BasicInfoNotifier, BasicInfoState>(
        (ref) {

          final supplierData = ProfileSupplierData();

  return BasicInfoNotifier(supplierData: supplierData);
});

class BasicInfoState {
  final Name name;
  final LastName lastName;
  final Email email;
  final PhoneNumber phoneNumber;
  final Location location;
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;

  const BasicInfoState({
    this.name = const Name.pure(),
    this.lastName = const LastName.pure(),
    this.email = const Email.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.location = const Location.pure(),
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
  });

  BasicInfoState copyWith({
    Name? name,
    LastName? lastName,
    Email? email,
    PhoneNumber? phoneNumber,
    Location? location,
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
  }) =>
      BasicInfoState(
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        location: location ?? this.location,
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
      );
}

class BasicInfoNotifier extends StateNotifier<BasicInfoState> {
  final ProfileSupplierData supplierData;
  BasicInfoNotifier({required this.supplierData}) : super(const BasicInfoState());

  onNameChange(String value) {
    final newName = Name.dirty(value);
    state = state.copyWith(
        name: newName,
        isValid: Formz.validate([
          newName,
          state.lastName,
          state.email,
          state.phoneNumber,
          state.location
        ]));
  }

  onLastNameChange(String value) {
    final newLastName = LastName.dirty(value);
    state = state.copyWith(
        lastName: newLastName,
        isValid: Formz.validate([
          newLastName,
          state.name,
          state.email,
          state.phoneNumber,
          state.location
        ]));
  }

  onPhoneNumberChange(String value) {
    final newPhoneNumber = PhoneNumber.dirty(value);
    state = state.copyWith(
        phoneNumber: newPhoneNumber,
        isValid: Formz.validate([
          newPhoneNumber,
          state.name,
          state.lastName,
          state.email,
          state.location
        ]));
  }

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
        email: newEmail,
        isValid: Formz.validate([
          newEmail,
          state.name,
          state.lastName,
          state.phoneNumber,
          state.location
        ]));
  }

  onLocationChanged(String value) {
    final newLocation = Location.dirty(value);
    state = state.copyWith(
        location: newLocation,
        isValid: Formz.validate([
          newLocation,
          state.name,
          state.lastName,
          state.email,
          state.phoneNumber
        ]));
  }

  onFormSubmit(String userId) async {
    _touchEveryField();
    if (!state.isValid) return;


    state = state.copyWith(isPosting: true);

    try {
      await supplierData.sendBasicInformation(userId, state.name.value, state.lastName.value, state.email.value, state.phoneNumber.value, state.location.value);
      
    } catch (e) {
      state = state.copyWith(isPosting: false);
    }
    state = state.copyWith(isPosting: false);
  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final location = Location.dirty(state.location.value);
    final name = Name.dirty(state.name.value);
    final lastName = LastName.dirty(state.lastName.value);
    final phoneNumber = PhoneNumber.dirty(state.phoneNumber.value);
    state = state.copyWith(
        isFormPosted: true,
        email: email,
        location: location,
        name: name,
        lastName: lastName,
        phoneNumber: phoneNumber,
        isValid:
            Formz.validate([email, location, name, lastName, phoneNumber]));
  }
}