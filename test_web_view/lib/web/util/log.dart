import 'package:flutter/foundation.dart';

class Log {
  Log._(); // private constructor

  static Future<void> t(
    String message,
    void Function() func, {
    bool time = true,
    bool filePath = false,
  }) async {
    final startTime = DateTime.now();
    func();
    final endTime = DateTime.now();
    final executionTime = endTime.difference(startTime);
    _print(
        '[TIME CHECK]', '$message 실행 시간: ${executionTime.inMicroseconds} 마이크로초',
        isTime: time, isFilePath: filePath);
  }

  static void d(
    String message, {
    bool time = true,
    bool filePath = false,
  }) {
    _print('[Debug]', message, isTime: time, isFilePath: filePath);
  }

  static void e(
    String message, {
    bool time = true,
    bool filePath = true,
  }) {
    _print('[Error]', message, isTime: time, isFilePath: filePath);
  }

  static void w(
    String message, {
    bool time = true,
    bool filePath = true,
  }) {
    _print('[Warning]', message, isTime: time, isFilePath: filePath);
  }

  static void i(
    String message, {
    bool time = true,
    bool filePath = true,
  }) {
    _print('[Info]', message, isTime: time, isFilePath: filePath);
  }

  static _print(
    String tag,
    String message, {
    required bool isTime,
    required bool isFilePath,
  }) {
    if (!kDebugMode) {
      return;
    }

    print("$tag${_getTime(isTime)}${_getClassPath(isFilePath)} $message");
  }

  static String _getTime(bool isTime) {
    return isTime ? '[$time]' : '';
  }

  static String _getClassPath(bool isFilePath) {
    final stackTrace = StackTrace.current.toString().split('\n');
    // debugPrintStack(stackTrace: StackTrace.current);

    if (!isFilePath || stackTrace.length <= 3) {
      return '';
    }

    final currentStack = stackTrace[3].trim();
    final match = RegExp(r'\(([^)]+)\)').firstMatch(currentStack);

    if (match != null && match[1] != null) {
      return '[${match[1]}]';
    }

    return '[$currentStack]';
  }

  static String get time => DateTime.now().toString();
}
