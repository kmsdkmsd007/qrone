import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:qrone/features/products/product_model.dart';
import 'package:qrone/features/products/product_state.dart';
import 'package:qrone/helpers/NotifierWrapper.dart';
import 'package:qrone/state/extensions/exception_helper.dart';
import 'package:qrone/state/extensions/postgresexceptions.dart';
import 'package:qrone/state/framework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductController extends ValueNotifier<ProductState> {
  final GlobalKey<NavigatorState> navigatorKey;

  ProductController({required this.navigatorKey}) : super(createProductState());
  void getAllProducts() async {
    await Supabase.instance.client.getDataList<ProductModel>(
      tableName: "products",
      onSuccess: (e) => emit(value.copyWith(products: ~e)),
      fromJsonList: (f) => f.map((m) => m.toProductModel()!).toList(),
      query:
          (tableName) => Supabase.instance.client
              .from(tableName)
              .select(
                'id, price:prices(id, updated_at, current_price, previous_price), category:categories(id, title), name, barcode, product_image, company:companies(id, name)',
              )
              .order('name', ascending: true),
      // .ilike('title', '%C%')
      onError: (e) => emit(value.copyWith(error: e.getErrorMessage())),
      showLoading: () => emit(value.copyWith(isLoading: true)),
      hideLoading: () => emit(value.copyWith(isLoading: false)),
    );
  }

  modifyProduct(ProductModel p) {
    value = value.copyWith(selectedProduct: p);
  }

  // Method to resize and compress the image
  Future<File> _resizeAndCompressImage(
    File imageFile,
    String productName,
  ) async {
    final bytes = await imageFile.readAsBytes();
    img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
    img.Image resizedImage = img.copyResize(image, width: 400);
    List<int> compressedBytes = img.encodeJpg(resizedImage, quality: 40);

    final directory = await getApplicationDocumentsDirectory();
    final resizedFile = File('${directory.path}/$productName.jpg');
    await resizedFile.writeAsBytes(compressedBytes);

    return resizedFile;
  }

  Future<String> handleImageUpload(String filePath, String fileName) async {
    final file = await _resizeAndCompressImage(File(filePath), fileName);
    final bucket = Supabase.instance.client.storage.from('product-images');

    await bucket.upload(
      "${Supabase.instance.client.auth.currentUser!.id}/$fileName",
      file,
    );
    return bucket.getPublicUrl(
      "${Supabase.instance.client.auth.currentUser!.id}/$fileName",
    );
  }

  void addPr(ProductModel p) async {
    value = value.copyWith(isLoading: true);
    try {
      final imageUrl = await handleImageUpload(p.imageUrl, p.name);

      final response = await Supabase.instance.client.rpc(
        'add_product_with_price',
        params: {
          'p_name': p.name,
          'p_price': p.price.current_price,
          'p_barcode': p.barCode,
          'p_category_id': p.category.id,
          'p_company_id': p.company.id,
          'p_product_image': imageUrl,
        },
      );
      if (response['added'] = true) {
        ScaffoldMessenger.of(
          navigatorKey.currentContext!,
        ).showSnackBar(SnackBar(content: Text('Product added successfully')));
        getAllProducts();

        Navigator.of(navigatorKey.currentContext!).pop();
      } else {
        ScaffoldMessenger.of(
          navigatorKey.currentContext!,
        ).showSnackBar(SnackBar(content: Text(response['reason'])));
      }
    } on PostgrestException catch (e) {
      value = value.copyWith(isLoading: false);
      ScaffoldMessenger.of(
        navigatorKey.currentContext!,
      ).showSnackBar(SnackBar(content: Text(e.friendlyMessage)));
      print(e.toString());
    } catch (e) {
      print(e.toString());
      value = value.copyWith(error: e.toString(), isLoading: false);
    }
  }
}
