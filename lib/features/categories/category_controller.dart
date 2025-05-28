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

  CategoryController({required this.navigatorKey})
    : super(createCategoryState());

  void getAllCategories() async {
    await Supabase.instance.client.getDataList<CategoryModel>(
      tableName: "categories",
      onSuccess: (e) => emit(value.copyWith(categories: ~e)),
      fromJsonList: (f) => f.map((m) => m.toCategoryModel()!).toList(),
      query:
          (tableName) => Supabase.instance.client
              .from(tableName)
              .select()
              .order('title', ascending: true),

      // .ilike('title', '%C%')
      onError: (e) => emit(value.copyWith(error: e.getErrorMessage())),
      showLoading: () => emit(value.copyWith(isLoading: true)),
      hideLoading: () => emit(value.copyWith(isLoading: false)),
    );
  }

  addCategory(String category) async {
    try {
      value = value.copyWith(
        addState: value.addCategoryState.copyWith(
          isLoading: true,
          isAdded: false,
        ),
      );

      await Supabase.instance.client.from('categories').insert({
        "title": category,
      });
      value = value.copyWith(
        addState: value.addCategoryState.copyWith(
          isLoading: false,
          isAdded: true,
        ),
      );

      getAllCategories();
      ScaffoldMessenger.of(
        navigatorKey.currentContext!,
      ).showSnackBar(SnackBar(content: Text("Category Added Successfully!")));
      navigatorKey.currentState?.pop();
    } on PostgrestException catch (e) {
      ScaffoldMessenger.of(
        navigatorKey.currentState!.context,
      ).showSnackBar(SnackBar(content: Text(e.friendlyMessage)));
      value = value.copyWith(
        addState: value.addCategoryState.copyWith(
          isLoading: false,
          isAdded: false,
        ),
      );
    }
  }
}
