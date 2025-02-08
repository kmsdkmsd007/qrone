import 'package:qrone/features/categories/category_model.dart';
import 'package:qrone/features/companies/company_model.dart';

typedef ProductModel = ({
  int id,
  String name,
  String imageUrl,
  int priceId,
  CompanyModel company,
  double price,
  CategoryModel category,
  String barCode,
});

ProductModel productAttribute({
  required int id,
  required String name,
  required CompanyModel company,
  required String imageUrl,
  required int priceId,
  required double price,
  required CategoryModel category,
  required String barCode,
}) =>
    (
      id: id,
      name: name,
      company: company,
      imageUrl: imageUrl,
      priceId: priceId,
      price: price,
      category: category,
      barCode: barCode,
    );

extension ProductModelExtension on ProductModel {
  ProductModel copyWith({
    int? id,
    String? name,
    CompanyModel? company,
    String? imageUrl,
    int? priceId,
    double? price,
    CategoryModel? category,
    String? barCode,
  }) =>
      (
        id: id ?? this.id,
        name: name ?? this.name,
        company: company ?? this.company,
        imageUrl: imageUrl ?? this.imageUrl,
        priceId: priceId ?? this.priceId,
        price: price ?? this.price,
        category: category ?? this.category,
        barCode: barCode ?? this.barCode,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'company_id': company.id,
        'product_image': imageUrl,
        'price_id': priceId,

        'category_id': category.id, // Assuming CategoryModel has toJson method
        'barcode': "barCode",
      };
}

extension ProductModelJson on Map<String, dynamic> {
  ProductModel? toProductModel() => switch (this) {
        {
          'id': final int id,
          'name': final String name,
          'company_id': final int companyId,
          'company_name': final String companyName,
          'product_image': final String imageUrl,
          'price_id': final int priceId,
          'price': final num price,
          'category': final Map<String, dynamic> categoryJson,
          'bar_code': final String barCode,
        } =>
          (
            id: id,
            name: name,
            company: companyModel(
              id: companyId,
              name: companyName,
            ),
            imageUrl: imageUrl,
            priceId: priceId,
            price: price.toDouble(),
            category: categoryJson
                .toCategoryModel()!, // Assuming you have this extension method
            barCode: barCode,
          ),
        _ => null
      };
}
