import 'package:formz/formz.dart';

enum ContentPostError { empty, format }

class ContentPost extends FormzInput<String, ContentPostError> {

  const ContentPost.pure() : super.pure('');

  const ContentPost.dirty( String value ) : super.dirty(value);



  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == ContentPostError.empty ) return 'El campo es requerido';

    return null;
  }

  @override
  ContentPostError? validator(String value) {
    
    if ( value.isEmpty || value.trim().isEmpty ) return ContentPostError.empty;

    return null;
  }
}