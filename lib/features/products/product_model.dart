import 'package:qrone/features/categories/category_model.dart';
import 'package:qrone/features/companies/company_model.dart';

typedef PriceModel =
    ({int id, String updated_at, num current_price, num previous_price});

PriceModel createPriceModel({
  int id = -1,
  String updated_at = "",
  num current_price = 0,
  num previous_price = 0,
}) => (
  id: id,
  current_price: current_price,
  previous_price: previous_price,
  updated_at: updated_at,
);

extension PriceModelExtension on PriceModel {
  PriceModel copyWith({
    int? id,
    double? current_price,
    double? previous_price,
    String? updated_at,
  }) => (
    id: id ?? this.id,
    current_price: current_price ?? this.current_price,
    previous_price: previous_price ?? this.previous_price,
    updated_at: updated_at ?? this.updated_at,
  );

  Map<String, dynamic> toJson() => {
    'current_price': current_price,
    'previous_price': previous_price,
    'updated_at': updated_at,
  };
}

extension PriceModelJson on Map<String, dynamic> {
  PriceModel? toPriceModel() => switch (this) {
    {
      'id': final int id,
      'updated_at': final String updated_at,
      'current_price': final num current_price,
      'previous_price': final num previous_price,
    } =>
      createPriceModel(
        id: id,
        updated_at: updated_at,
        current_price: current_price,
        previous_price: previous_price,
      ),
    _ => null,
  };
}

typedef ProductModel =
    ({
      int id,
      String name,
      String imageUrl,
      CompanyModel company,
      PriceModel price,
      CategoryModel category,
      String barCode,
    });

ProductModel createProductModel({
  required int id,
  required String name,
  required CompanyModel company,
  required String imageUrl,
  required PriceModel price,
  required CategoryModel category,
  required String barCode,
}) => (
  id: id,
  name: name,
  company: company,
  imageUrl: imageUrl,
  price: price,
  category: category,
  barCode: barCode,
);

extension ProductModelExtension on ProductModel {
  Map<String, dynamic> toJson() => {
    'name': name,
    'company_id': company.id,
    'product_image': imageUrl,
    'category_id': category.id,
    'barcode': barCode,
  };
  ProductModel copyWith({
    int? id,
    String? name,
    CompanyModel? company,
    String? imageUrl,
    PriceModel? price,
    CategoryModel? category,
    String? barCode,
  }) => (
    id: id ?? this.id,
    name: name ?? this.name,
    company: company ?? this.company,
    imageUrl: imageUrl ?? this.imageUrl,
    price: price ?? this.price,
    category: category ?? this.category,
    barCode: barCode ?? this.barCode,
  );
}

typedef ImageOrNull(String imageUrl);

extension ProductModelJson on Map<String, dynamic> {
  ProductModel? toProductModel() => switch (this) {
    {
      'id': final int id,
      'name': final String name,
      'company': final Map<String, dynamic> company,
      'product_image': final String? imageUrl,
      'price': final Map<String, dynamic> price,
      'category': final Map<String, dynamic> category,
      'barcode': final String barCode,
    } =>
      createProductModel(
        id: id,
        name: name,
        company: company.toCompanyModel()!,
        imageUrl: imageUrl ?? "",
        price: price.toPriceModel()!,
        category: category.toCategoryModel()!,
        barCode: barCode,
      ),
    _ => null,
  };
}
