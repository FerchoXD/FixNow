import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {

  static initEnvironment() async {
    await dotenv.load(fileName: ".env");
  }

  static String apiUrl = dotenv.env['API_URL'] ?? 'https://f2db-2806-262-3404-9c-342b-4c1a-df3a-a5d1.ngrok-free.app/api/v1';
}
