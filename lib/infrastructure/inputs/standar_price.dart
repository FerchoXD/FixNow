import 'package:formz/formz.dart';

// Define input validation errors
enum StandarPriceError { empty, format, range }

// Extend FormzInput and provide the input type and error type.
class StandarPrice extends FormzInput<double, StandarPriceError> {
  // Call super.pure to represent an unmodified form input.
  const StandarPrice.pure() : super.pure(0.0);

  // Call super.dirty to represent a modified form input.
  const StandarPrice.dirty(double value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == StandarPriceError.empty) return 'El campo es requerido';
    if (displayError == StandarPriceError.format) return 'Debe ser un número válido';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  StandarPriceError? validator(double value) {
    if (value == 0.0) return StandarPriceError.empty;
    if (value.isNaN || value.isInfinite) return StandarPriceError.format;

    return null;
  }
}
