import 'package:fixnow/domain/entities/message.dart';

class MessageWithProviders {
  final String text;
  final List suppliers;
  final FromWho fromWho;

  MessageWithProviders({
    required this.text,
    required this.suppliers,
    required this.fromWho,
  });
}
