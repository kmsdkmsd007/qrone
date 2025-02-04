import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

extension SupabaseClientExtension on SupabaseClient {
  Future<void> getDataList<T>({
    required String tableName,
    required void Function(List<T> data) onSuccess,
    required List<T> Function(List<Map<String, dynamic>>) fromJsonList,
    required PostgrestTransformBuilder<List<Map<String, dynamic>>> Function(
      String,
    )? query,
    required void Function(Exception error) onError,
    required void Function() showLoading,
    required void Function() hideLoading,
  }) async {
    try {
      showLoading();
      final response =
          await (query == null ? from(tableName).select() : query(tableName));
      final data = fromJsonList(response);
      onSuccess(data);
    } on Exception catch (e) {
      onError(e);
    } finally {
      hideLoading();
    }
  }
}

extension UpdateValue on ValueNotifier<dynamic> {
  void emit(dynamic va) {
    value = va;
  }
}
