import 'package:logger/logger.dart';

class Log {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      colors: true,
      lineLength: 1,
      errorMethodCount: 1,
      methodCount: 1,
      printEmojis: false,
    ),
  );

  static void debug(String msg) {
    _logger.e(msg);
  }

  static void info(String msg) {
    _logger.i(msg);
  }

  static void warning(String msg) {
    _logger.w(msg);
  }

  static void error(String msg) {
    _logger.e(msg);
  }

  static void fatal(String msg) {
    _logger.f(msg);
  }
}
