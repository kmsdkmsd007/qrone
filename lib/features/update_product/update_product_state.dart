import 'package:qrone/features/products/product_model.dart';

typedef UpdateProductState = ({
  bool isLoading,
  String error,
  ProductModel product
});
UpdateProductState createUpdateProductState({
  bool isLoading = false,
  String error = '',
  ProductModel product = (
    barCode: '',
    imageUrl: '',
    name: '',
    price: (current_price: 0, updated_at: "", previous_price: 0, id: -1),
    company: (id: -1, name: ''),
    category: (id: -1, name: ''),
    id: 0
  ),
}) =>
    (
      isLoading: isLoading,
      error: error,
      product: product,
    );

extension UpdateProductStateExtensions on UpdateProductState {
  UpdateProductState copyWith({
    bool? isLoading,
    String? error,
    ProductModel? product,
  }) =>
      createUpdateProductState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        product: product ?? this.product,
      );
}
