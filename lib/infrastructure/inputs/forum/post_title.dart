import 'package:formz/formz.dart';

// Define input validation errors
enum TitlePostError { empty, format }

// Extend FormzInput and provide the input type and error type.
class TitlePost extends FormzInput<String, TitlePostError> {

  // Call super.pure to represent an unmodified form input.
  const TitlePost.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const TitlePost.dirty( String value ) : super.dirty(value);



  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == TitlePostError.empty ) return 'El campo es requerido';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  TitlePostError? validator(String value) {
    
    if ( value.isEmpty || value.trim().isEmpty ) return TitlePostError.empty;

    return null;
  }
}