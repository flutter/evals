import 'dart:io';

import 'package:logging/logging.dart';

class EvalLogger {
  EvalLogger._();

  static Level _level = Level.INFO;
  static IOSink? logFile;
  static String logDir = './logs';
  static DateTime runStart = DateTime.now();

  static void init({
    Level? level,
    IOSink? sink,
    String? logDir,
  }) {
    _level = level ?? _level;
  }
}
