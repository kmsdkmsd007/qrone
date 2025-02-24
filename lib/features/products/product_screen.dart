import 'package:flutter/material.dart';
import 'package:qrone/features/products/product_controller.dart';
import 'package:qrone/features/products/product_model.dart';
import 'package:qrone/main.dart';
import 'package:qrone/navigation/navigations.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});
  final controller = container.get<ProductController>();
  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, data, child) => data.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : data.error.isNotEmpty
                ? Center(
                    child: Text(data.error),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: controller.value.products.length,
                      itemBuilder: (context, index) => ProductCard(
                        product: controller.value.products[index],
                        index: index,
                      ),
                    ),
                  ),
      );
}

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final int index;

  const ProductCard({required this.product, required this.index});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(Routes.productDetails, arguments: product.id);
        },
        child: Card(
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: '${product.id}',
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(product.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      product.company.name,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      product.category.name,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      product.price.current_price.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
