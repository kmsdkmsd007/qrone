import 'package:qrone/features/products/product_model.dart';
import 'package:qrone/state/models/immutable_list.dart';

typedef ProductState = ({
  ImmutableList<ProductModel> products,
  bool isLoading,
  String error,
  ProductModel selectedProduct,
});

ProductState createProductState({
  ImmutableList<ProductModel> products = const ImmutableList.empty(),
  bool isLoading = false,
  ProductModel selectedProduct = (
    barCode: '',
    imageUrl: '',
    name: '',
    price: 0,
    priceId: 0,
    company: (id: -1, name: ''),
    category: (id: -1, name: ''),
    id: 0
  ),
  String error = '',
}) =>
    (
      error: error,
      products: products,
      isLoading: isLoading,
      selectedProduct: selectedProduct
    );

extension ProductStateExtensions on ProductState {
  ProductState copyWith({
    bool? isLoading,
    ProductModel? selectedProduct,
    ImmutableList<ProductModel>? products,
    String? error,
  }) =>
      createProductState(
        selectedProduct: selectedProduct ?? this.selectedProduct,
        error: error ?? this.error,
        products: products ?? this.products,
        isLoading: isLoading ?? this.isLoading,
      );
}
