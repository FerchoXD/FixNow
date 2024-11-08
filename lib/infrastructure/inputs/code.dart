import 'package:formz/formz.dart';

// Define input validation errors
enum CodeError { empty, length, format }

// Extend FormzInput and provide the input type and error type.
class Code extends FormzInput<String, CodeError> {

  // Call super.pure to represent an unmodified form input.
  const Code.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Code.dirty( String value ) : super.dirty(value);


  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == CodeError.empty ) return 'El campo es requerido';
    if ( displayError == CodeError.length ) return 'Mínimo 6 caracteres';

    return null;
  }


  // Override validator to handle validating a given input value.
  @override
  CodeError? validator(String value) {

    if ( value.isEmpty || value.trim().isEmpty ) return CodeError.empty;
    if ( value.length < 6 ) return CodeError.length;

    return null;
  }
}