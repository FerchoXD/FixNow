import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {

  static initEnvironment() async {
    await dotenv.load(fileName: ".env");
  }

  static String apiUrl = dotenv.env['API_URL'] ?? 'https://fb78-2806-10ae-f-9d7-dd56-bae-7d88-33ee.ngrok-free.app/api/v1';
}
