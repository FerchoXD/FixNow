import 'package:formz/formz.dart';

// Define input validation errors
enum StandardTextError { empty, format }

// Extend FormzInput and provide the input type and error type.
class StandarText extends FormzInput<String, StandardTextError> {

  // Call super.pure to represent an unmodified form input.
  const StandarText.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const StandarText.dirty( String value ) : super.dirty(value);



  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == StandardTextError.empty ) return 'El campo es requerido';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  StandardTextError? validator(String value) {
    
    if ( value.isEmpty || value.trim().isEmpty ) return StandardTextError.empty;

    return null;
  }
}