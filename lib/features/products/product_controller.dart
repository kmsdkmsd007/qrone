import 'dart:io';

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

  modifyProduct(ProductModel p) {
    value = value.copyWith(selectedProduct: p);
  }

  Future<int> _insertPrice(double price) async {
    final response = await Supabase.instance.client
        .from('prices')
        .insert({'current_price': price, 'previous_price': price})
        .select('id')
        .single();
    return response['id'];
  }

  Future<String> _uploadImage(File image) async {
    await Supabase.instance.client.storage.from('product-images').upload(
          'public/${image.path.split('/').last}',
          image,
          fileOptions: FileOptions(cacheControl: '3600', upsert: false),
        );

    final publicUrl = Supabase.instance.client.storage
        .from('product-images')
        .getPublicUrl('public/${image.path.split('/').last}');
    return publicUrl;
  }

  void addProduct(ProductModel p) async {
    value = value.copyWith(isLoading: true);
    try {
      final priceId = await _insertPrice(p.price);
      final imageUrl = await _uploadImage(File(p.imageUrl));
      final productWithDetails =
          p.copyWith(priceId: priceId, imageUrl: imageUrl);
      final a = await Supabase.instance.client
          .from('products')
          .upsert(productWithDetails.toJson())
          .select();
      final products = a.map((e) => e.toProductModel()!).toList();
      value = value.copyWith(isLoading: false, products: ~products);
      Navigator.of(navigatorKey.currentContext!).pop();
    } on PostgrestException catch (e) {
      value = value.copyWith(error: e.friendlyMessage, isLoading: false);
      print(e.toString());
    } catch (e) {
      print(e.toString());

      value = value.copyWith(error: e.toString(), isLoading: false);
    }
  }
}
