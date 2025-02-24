import 'package:flutter/material.dart';
import 'package:qrone/features/products/product_controller.dart';
import 'package:qrone/main.dart';
import 'package:qrone/navigation/navigations.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({super.key, required this.id});
  final productController = container.get<ProductController>();
  final int id;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Details'),
          actions: [
            TextButton(
              child: const Text('Edit'),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.updateProduct,
                  arguments: productController.value.products
                      .firstWhere((p) => p.id == id),
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          child: ValueListenableBuilder(
            valueListenable: productController,
            builder: (context, data, child) {
              final p = data.products.firstWhere((p) => p.id == id);
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: p.id.toString(),
                        child: Image.network(
                          p.imageUrl,
                        ),
                      ),
                      Text(
                        p.name,
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                      ),
                      Divider(color: Colors.grey),
                      Text(
                        'Price: \$${p.price.current_price}',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                      ),
                      Divider(color: Colors.grey),
                      Text(
                        'Category: ${p.category.name}',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                      ),
                      Divider(color: Colors.grey),
                      Text(
                        'Company: ${p.company.name}',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                      ),
                      SizedBox(height: 16.0),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
}
