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

    final supabase = Supabase.instance.client;

    final a = await supabase.from('products').select(
          'id, price_id, category_id, name, barcode, product_image, company:companies(id, name)',
        );

    print(a);
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
    final name = image.path.split('/').last;
    await Supabase.instance.client.storage.from('product-images').upload(
          '${Supabase.instance.client.auth.currentUser!.id}/a$name',
          image,
        );

    final publicUrl = Supabase.instance.client.storage
        .from('product-images/${Supabase.instance.client.auth.currentUser!.id}')
        .getPublicUrl('a$name');
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
          .insert(productWithDetails.toJson())
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
