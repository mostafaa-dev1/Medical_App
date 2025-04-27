import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseErrorHandler {
  static String handleDatabaseError(PostgrestException e) {
    switch (e.code) {
      case '23505':
        return 'Auth.userExists';
      case '23503':
        return 'Auth.formatError';
      case '22001':
        return 'Auth.dataTooLong';
      default:
        log(e.toString());
        return 'Auth.unexpectedError';
    }
  }

  static String handleNetworkError(Exception e) {
    if (e is SocketException || e is TimeoutException) {
      return 'Auth.networkError';
    }
    return 'Auth.unexpectedError';
  }
}
