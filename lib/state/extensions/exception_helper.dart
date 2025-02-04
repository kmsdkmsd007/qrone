import 'dart:async';
import 'dart:io';

import 'package:qrone/state/extensions/postgresexceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

extension ExceptionHelper on Exception {
  String getErrorMessage() {
    if (this is PostgrestException) {
      return (this as PostgrestException).friendlyMessage;
    } else if (this is SocketException) {
      return 'No internet connection. Please check your network.';
    } else if (this is HttpException) {
      return 'HTTP error occurred.';
    } else if (this is FormatException) {
      return 'Invalid data format.';
    } else if (this is TimeoutException) {
      return 'Request timeout. Please try again.';
    } else {
      return 'An unexpected error occurred: ${toString()}';
    }
  }

  bool get isNetworkError => this is SocketException;

  bool get isHttpError => this is HttpException;

  bool get isFormatError => this is FormatException;

  bool get isTimeoutError => this is TimeoutException;
}
