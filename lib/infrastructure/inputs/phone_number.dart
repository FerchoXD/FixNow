import 'package:formz/formz.dart';

// Define input validation errors
enum PhoneNumberError { empty, length, format }

// Extend FormzInput and provide the input type and error type.
class PhoneNumber extends FormzInput<String, PhoneNumberError> {
  // Call super.pure to represent an unmodified form input.
  const PhoneNumber.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const PhoneNumber.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PhoneNumberError.empty) return 'El campo es requerido';
    if (displayError == PhoneNumberError.length) return 'El número no es de 10 dígitos';
    if (displayError == PhoneNumberError.format) return 'El número solo debe contener dígitos';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  PhoneNumberError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return PhoneNumberError.empty;
    if (value.length < 10) return PhoneNumberError.length;
    if (!RegExp(r'^\d+$').hasMatch(value)) return PhoneNumberError.format;

    return null;
  }
}
