typedef ProductModel = ({
  int id,
  String name,
  int companyId,
  String companyName,
  String imageUrl,
  int priceId,
  double price,
  int categoryId,
  String categoryTitle,
  String barCode,
});

ProductModel productAttribute({
  required int id,
  required String name,
  required int companyId,
  required String companyName,
  required String imageUrl,
  required int priceId,
  required double price,
  required int categoryId,
  required String categoryTitle,
  required String barCode,
}) =>
    (
      id: id,
      name: name,
      companyId: companyId,
      companyName: companyName,
      imageUrl: imageUrl,
      priceId: priceId,
      price: price,
      categoryId: categoryId,
      categoryTitle: categoryTitle,
      barCode: barCode,
    );

extension ProductModelExtension on ProductModel {
  ProductModel copyWith({
    int? id,
    String? name,
    int? companyId,
    String? companyName,
    String? imageUrl,
    int? priceId,
    double? price,
    int? categoryId,
    String? categoryTitle,
    String? barCode,
  }) =>
      (
        id: id ?? this.id,
        name: name ?? this.name,
        companyId: companyId ?? this.companyId,
        companyName: companyName ?? this.companyName,
        imageUrl: imageUrl ?? this.imageUrl,
        priceId: priceId ?? this.priceId,
        price: price ?? this.price,
        categoryId: categoryId ?? this.categoryId,
        categoryTitle: categoryTitle ?? this.categoryTitle,
        barCode: barCode ?? this.barCode,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'company_id': companyId,
        'product_image': imageUrl,
        'price_id': priceId,
        'category_id': categoryId,
        'barcode': barCode,
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
          'category_id': final int categoryId,
          'category_title': final String categoryTitle,
          'bar_code': final String barCode,
        } =>
          (
            id: id,
            name: name,
            companyId: companyId,
            companyName: companyName,
            imageUrl: imageUrl,
            priceId: priceId,
            price: price.toDouble(),
            categoryId: categoryId,
            categoryTitle: categoryTitle,
            barCode: barCode,
          ),
        _ => null
      };
}
