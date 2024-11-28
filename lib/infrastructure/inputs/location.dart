import 'package:formz/formz.dart';

// Define input validation errors
enum LocationError { empty, format }

// Extend FormzInput and provide the input type and error type.
class Location extends FormzInput<String, LocationError> {

  // Call super.pure to represent an unmodified form input.
  const Location.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Location.dirty( String value ) : super.dirty(value);



  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == LocationError.empty ) return 'El campo es requerido';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  LocationError? validator(String value) {
    
    if ( value.isEmpty || value.trim().isEmpty ) return LocationError.empty;

    return null;
  }
}