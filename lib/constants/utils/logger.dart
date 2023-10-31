import 'package:logger/logger.dart';

class AppLogger {
   static final Logger logger = Logger(printer: PrettyPrinter());

  static void logInfo(String message) {
    logger.i(message);
  }

  static void logWarning(String message) {
    logger.w(message);
  }

  static void logError(String message, dynamic e) {
    logger.e("Error occured: $e");
  }
}