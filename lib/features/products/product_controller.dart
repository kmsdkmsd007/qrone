import 'package:flutter/material.dart';
import 'package:qrone/features/products/product_model.dart';
import 'package:qrone/features/products/product_state.dart';
import 'package:qrone/state/extensions/postgresexceptions.dart';
import 'package:qrone/state/framework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductController extends ValueNotifier<ProductState> {
  final GlobalKey<NavigatorState> navigatorKey;

  ProductController({
    required this.navigatorKey,
  }) : super(createProductState());
  void getAllProducts() async {
    value = value.copyWith(isLoading: true);
    try {
      final a = await Supabase.instance.client.from('products').select();
      final products = a.map((e) => e.toProductModel()!).toList();
      value = value.copyWith(isLoading: false, products: ~products);
    } on PostgrestException catch (e) {
      value = value.copyWith(error: e.friendlyMessage, isLoading: false);
    } catch (e) {
      value = value.copyWith(error: e.toString(), isLoading: false);
    }
  }
}
