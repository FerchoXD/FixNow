// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fixnow/infrastructure/inputs.dart';
// import 'package:formz/formz.dart';

// class LoginFormState {
//   final bool isPosting;
//   final bool isFormPosted;
//   final bool isValid;
//   final bool userRegistred;
//   final Name name;
//   final LastName lastName;
//   final Email email;
//   final PhoneNumber phoneNumber;
//   final Password password;

//   LoginFormState({
//     this.isPosting = false,
//     this.isFormPosted = false,
//     this.isValid = false,
//     this.userRegistred = false,
//     this.name = const Name.pure(),
//     this.lastName = const LastName.pure(),
//     this.email = const Email.pure(),
//     this.phoneNumber = const PhoneNumber.pure(),
//     this.password = const Password.pure(),
//   });

//   LoginFormState copyWith({
//     bool? isPosting,
//     bool? isFormPosted,
//     bool? isValid,
//     Name? name,
//     LastName? lastName,
//     Email? email,
//     PhoneNumber? phoneNumber,
//     Password? password,
//     bool? userRegistred,
//   }) =>
//       LoginFormState(
//         isPosting: isPosting ?? this.isPosting,
//         isFormPosted: isFormPosted ?? this.isFormPosted,
//         isValid: isValid ?? this.isValid,
//         name: name ?? this.name,
//         lastName: lastName ?? this.lastName,
//         email: email ?? this.email,
//         phoneNumber: phoneNumber ?? this.phoneNumber,
//         password: password ?? this.password,
//         userRegistred: userRegistred ?? this.userRegistred,
//       );
// }

// class RegisterFormNotifier extends StateNotifier<LoginFormState> {

//   RegisterFormNotifier() : super(LoginFormState());

//   onNameChange(String value) {
//     final newName = Name.dirty(value);
//     state = state.copyWith(
//         name: newName,
//         isValid: Formz.validate([
//           newName,
//           state.lastName,
//           state.email,
//           state.phoneNumber,
//           state.password
//         ]));
//   }

//   onLastNameChange(String value) {
//     final newLastName = LastName.dirty(value);
//     state = state.copyWith(
//         lastName: newLastName,
//         isValid: Formz.validate([
//           newLastName,
//           state.name,
//           state.email,
//           state.phoneNumber,
//           state.password
//         ]));
//   }

//   onPhoneNumber(String value) {
//     final newPhoneNumber = PhoneNumber.dirty(value);
//     state = state.copyWith(
//         phoneNumber: newPhoneNumber,
//         isValid: Formz.validate([
//           newPhoneNumber,
//           state.name,
//           state.lastName,
//           state.email,
//           state.password
//         ]));
//   }

//   onEmailChange(String value) {
//     final newEmail = Email.dirty(value);
//     state = state.copyWith(
//         email: newEmail, isValid: Formz.validate([newEmail, state.password]));
//   }

//   onPasswordChange(String value) {
//     final newPassword = Password.dirty(value);
//     state = state.copyWith(
//         password: newPassword,
//         isValid: Formz.validate([newPassword, state.email]));
//   }

//   onFormSubmit() async {
//     _touchEveryField();
//     if (!state.isValid) return;

//     state = state.copyWith(isPosting: true);


//     state = state.copyWith(isPosting: false);
//   }

//   _touchEveryField() {
//     final email = Email.dirty(state.email.value);
//     final password = Password.dirty(state.password.value);
//     final name = Name.dirty(state.name.value);
//     final lastName = LastName.dirty(state.lastName.value);
//     final phoneNumber = PhoneNumber.dirty(state.phoneNumber.value);
//     state = state.copyWith(
//         isFormPosted: true,
//         email: email,
//         password: password,
//         name: name,
//         lastName: lastName,
//         phoneNumber: phoneNumber,
//         isValid: Formz.validate([email, password, name, lastName, phoneNumber]));
//   }
// }

// // final registerFormProvider =
// //     StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
// //         (ref) {
// //   final registerCallback = ref.watch(authProvider.notifier).registerUser;

// //   return RegisterFormNotifier(registerCallback: registerCallback);
// // });
