import 'package:supabase_flutter/supabase_flutter.dart';

extension PostgresExceptionX on PostgrestException {
  String get friendlyMessage {
    switch (code) {
      case '23505':
        return 'A record with the same value already exists.';
      case '23503':
        return 'This record is referenced by other records and cannot be deleted.';
      case '23502':
        return 'A required value was not provided.';
      case '42P01':
        return 'The specified table does not exist.';
      case '42703':
        return 'Column does not exist.';
      case '28P01':
        return 'Invalid credentials.';
      case '3D000':
        return 'Database does not exist.';
      default:
        return message;
    }
  }
}
