import 'dart:math';

class CodeGenerator {
  static String _lastGeneratedCode = '';
  static bool _hasMembers = false;

  static String generateCode(bool hasMembers) {
    if (hasMembers && _hasMembers) {
      return _lastGeneratedCode;
    }

    final random = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final code =
        List.generate(6, (index) => chars[random.nextInt(chars.length)]).join();

    _lastGeneratedCode = code;
    _hasMembers = hasMembers;
    return code;
  }
}
