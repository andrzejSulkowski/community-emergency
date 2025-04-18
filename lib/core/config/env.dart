import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get appTitle => dotenv.env['APP_TITLE'] ?? 'Emergency Group';

  // Code Configuration
  static int get codeLength => int.parse(dotenv.env['CODE_LENGTH'] ?? '6');
  static String get codeCharset =>
      dotenv.env['CODE_CHARSET'] ?? 'abcdefghijklmnopqrstuvwxyz0123456789';

  // UI Configuration
  static double get toggleWidth =>
      double.parse(dotenv.env['TOGGLE_WIDTH'] ?? '200.0');
  static double get toggleHeight =>
      double.parse(dotenv.env['TOGGLE_HEIGHT'] ?? '60.0');
  static double get toggleButtonWidth =>
      double.parse(dotenv.env['TOGGLE_BUTTON_WIDTH'] ?? '80.0');

  // Animation Durations
  static Duration get animationDuration => Duration(
    milliseconds: int.parse(dotenv.env['ANIMATION_DURATION_MS'] ?? '300'),
  );
}
