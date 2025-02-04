import 'package:flutter/material.dart';
import 'package:qrone/features/categories/category_model.dart';
import 'package:qrone/features/categories/category_state.dart';
import 'package:qrone/helpers/NotifierWrapper.dart';
import 'package:qrone/state/extensions/exception_helper.dart';
import 'package:qrone/state/extensions/postgresexceptions.dart';
import 'package:qrone/state/framework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryController extends ValueNotifier<CategoryState> {
  final GlobalKey<NavigatorState> navigatorKey;

  CategoryController({
    required this.navigatorKey,
  }) : super(createCategoryState());

  void getAllCategories() async {
    await Supabase.instance.client.getDataList<CategoryModel>(
      tableName: "categories",
      onSuccess: (e) => emit(value.copyWith(categories: ~e)),
      fromJsonList: (f) => f.map((m) => m.toCategoryModel()!).toList(),

      /// Queries the database table to find entries where the 'title' column contains
      /// either 'c' or 'C' (case-insensitive).
      /// Example matches: "Cat", "computer", "Spacecraft", "acceptance"
      /// @param tableName The name of the table to query
      /// @return A query builder instance that matches titles containing 'c' or 'C'
      query: (tableName) => Supabase.instance.client
          .from(tableName)
          .select()
          .ilike('title', '%C%'),
      onError: (e) => emit(value.copyWith(error: e.getErrorMessage())),
      showLoading: () => emit(value.copyWith(isLoading: true)),
      hideLoading: () => emit(
        value.copyWith(
          isLoading: false,
        ),
      ),
    );
  }

  addCategory(String category) async {
    try {
      value = value.copyWith(
        addState:
            value.addCategoryState.copyWith(isLoading: true, isAdded: false),
      );

      await Supabase.instance.client
          .from('categories')
          .insert({"title": category});
      value = value.copyWith(
        addState:
            value.addCategoryState.copyWith(isLoading: false, isAdded: true),
      );

      getAllCategories();
      navigatorKey.currentState?.pop();
    } on PostgrestException catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(
        SnackBar(
          content: Text(e.friendlyMessage),
        ),
      );
      value = value.copyWith(
        addState:
            value.addCategoryState.copyWith(isLoading: false, isAdded: false),
      );

      navigatorKey.currentState!.pop();
    }
  }
}
