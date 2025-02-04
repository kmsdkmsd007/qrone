import 'package:flutter/material.dart';
import 'package:qrone/features/categories/category_controller.dart';
import 'package:qrone/features/companies/company_controller.dart';
import 'package:qrone/features/products/product_controller.dart';
import 'package:qrone/features/products/product_model.dart';
import 'package:qrone/features/products/product_state.dart';
import 'package:qrone/main.dart';

class AddProductDialog extends StatelessWidget {
  AddProductDialog({super.key}) {
    // Fetch categories when dialog opens
    categoryController.getAllCategories();
  }
  final productController = container.get<ProductController>();
  final categoryController = container.get<CategoryController>();
  final companyController = container.get<CompanyController>();
  final GlobalKey formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text('Add Product'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
              ),
              ValueListenableBuilder(
                valueListenable: categoryController,
                builder: (context, value, child) {
                  if (value.error.isNotEmpty) {
                    return Text(
                      'Error: ${value.error}',
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.error),
                    );
                  }

                  return GestureDetector(
                    onTap: () {
                      companyController.getAllCompanies();
                    },
                    child: DropdownButtonFormField<int>(
                      decoration: const InputDecoration(labelText: 'Category'),
                      value: productController.value.selectedProduct.categoryId,
                      items: value.categories
                          .map(
                            (category) => DropdownMenuItem<int>(
                              value: category.id,
                              child: Text(category.name),
                            ),
                          )
                          .toList(),
                      icon: value.isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Icon(Icons.arrow_downward),
                      onChanged: (selectedId) {
                        if (selectedId != null) {
                          productController.value =
                              productController.value.copyWith(
                            selectedProduct: productController
                                .value.selectedProduct
                                .copyWith(categoryId: selectedId),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Add product
            },
            child: const Text('Add'),
          ),
        ],
      );
}
