import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qrone/features/products/product_controller.dart';
import 'package:qrone/features/products/product_model.dart';
import 'package:qrone/features/update_product/update_product_state.dart';
import 'package:qrone/main.dart';
import 'package:qrone/state/extensions/postgresexceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdateProductController extends ValueNotifier<UpdateProductState> {
  final GlobalKey<NavigatorState> navigatorKey;

  UpdateProductController({
    required this.navigatorKey,
  }) : super(createUpdateProductState());

  Future<String> updateImage(String filePath, String fileName) async {
    final file = File(filePath);
    final bucket = Supabase.instance.client.storage.from('product-images');
    await bucket.upload(
      "${Supabase.instance.client.auth.currentUser!.id}/$fileName",
      file,
      fileOptions: FileOptions(upsert: true),
    );

    final publicUrl = bucket.getPublicUrl(
      "${Supabase.instance.client.auth.currentUser!.id}/$fileName",
    );
    return publicUrl;
  }

  pickImage() async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      value = value.copyWith(
        product: value.product.copyWith(imageUrl: pickedFile.path),
      );
    }
  }

  Future<void> updatePrice(PriceModel p) async {
    await Supabase.instance.client
        .from('prices')
        .update(p.toJson())
        .eq('id', p.id);
  }

  updateProduct(
    ProductModel p, {
    String alternateUrl = "",
  }) async {
    try {
      if (p.imageUrl.isNotEmpty) {
        final link = await updateImage(p.imageUrl, p.name);
        p = p.copyWith(imageUrl: link);
      } else {
        p = p.copyWith(imageUrl: alternateUrl);
      }
      await updatePrice(p.price);
      await await Supabase.instance.client
          .from('products')
          .update(p.toJson())
          .eq('id', p.id);
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        SnackBar(content: Text('Product updated successfully')),
      );

      container.get<ProductController>().getAllProducts();
      navigatorKey.currentState!.pop();
    } on PostgrestException catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        SnackBar(content: Text(e.friendlyMessage)),
      );
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  modifyProduct(ProductModel p) {
    value = value.copyWith(product: p);
  }
}
