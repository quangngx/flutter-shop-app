import 'package:flutter/foundation.dart';

class LogHelper {
  final String prefix;

  const LogHelper(this.prefix);

  void log(String content) {
    if (kReleaseMode) {
      return;
    }

    debugPrint('$prefix $content');
  }
}
