import 'package:formz/formz.dart';

// Define input validation errors
enum HourlyRateError { empty, format }

// Extend FormzInput and provide the input type (double) and error type.
class HourlyRate extends FormzInput<double, HourlyRateError> {
  // Call super.pure to represent an unmodified form input.
  const HourlyRate.pure() : super.pure(0.0);

  // Call super.dirty to represent a modified form input.
  const HourlyRate.dirty(double value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == HourlyRateError.empty) return 'El campo es requerido';
    if (displayError == HourlyRateError.format) return 'Debe ser un número válido';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  HourlyRateError? validator(double value) {
    if (value == 0.0) return HourlyRateError.empty;
    if (value.isNaN || value.isInfinite) return HourlyRateError.format;

    return null;
  }
}
