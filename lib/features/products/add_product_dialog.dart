import 'package:flutter/material.dart';
import 'package:qrone/features/categories/category_controller.dart';
import 'package:qrone/features/categories/category_model.dart';
import 'package:qrone/features/companies/company_controller.dart';
import 'package:qrone/features/companies/company_model.dart';
import 'package:qrone/features/products/generalSelector.dart';
import 'package:qrone/features/products/product_controller.dart';
import 'package:qrone/features/products/product_model.dart';
import 'package:qrone/main.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddProductDialog extends StatelessWidget {
  AddProductDialog({super.key}) {
    // Fetch categories when dialog opens
    categoryController.getAllCategories();
  }
  final productController = container.get<ProductController>();
  final categoryController = container.get<CategoryController>();
  final companyController = container.get<CompanyController>();
  final GlobalKey formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController barCodeController = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      productController.modifyProduct(
        productController.value.selectedProduct.copyWith(
          imageUrl: pickedFile.path,
        ),
      );
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () {
                _pickImage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text('Camera'),
              onTap: () {
                _pickImage(ImageSource.camera);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Dialog.fullscreen(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ValueListenableBuilder(
            valueListenable: productController,
            builder: (context, data, child) => Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add Product',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Price',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      readOnly: true,
                      showCursor: false,
                      onTap: () {
                        categoryController.getAllCategories();
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => ValueListenableBuilder(
                            valueListenable: categoryController,
                            builder: (context, catVal, child) =>
                                Selector<CategoryModel>(
                              items: catVal.categories,
                              isLoading: catVal.isLoading,
                              selected: productController
                                  .value.selectedProduct.category,
                              onSelect: (CategoryModel category) {
                                productController.modifyProduct(
                                  data.selectedProduct.copyWith(
                                    category: category,
                                  ),
                                );
                                Navigator.pop(context);
                              },
                              text: (CategoryModel m) => Text(m.name),
                            ),
                          ),
                        );
                      },
                      decoration: InputDecoration(
                        hintText: data.selectedProduct.category.name.isEmpty
                            ? 'Select Category'
                            : data.selectedProduct.category.name,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      readOnly: true,
                      showCursor: false,
                      onTap: () {
                        companyController.getAllCompanies();
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => ValueListenableBuilder(
                            valueListenable: companyController,
                            builder: (context, comVal, child) =>
                                Selector<CompanyModel>(
                              items: comVal.companies,
                              isLoading: comVal.isLoading,
                              selected: productController
                                  .value.selectedProduct.company,
                              onSelect: (CompanyModel company) {
                                productController.modifyProduct(
                                  data.selectedProduct.copyWith(
                                    company: company,
                                  ),
                                );
                                Navigator.pop(context);
                              },
                              text: (CompanyModel m) => Text(m.name),
                            ),
                          ),
                        );
                      },
                      decoration: InputDecoration(
                        hintText: data.selectedProduct.company.name.isEmpty
                            ? 'Select Company'
                            : data.selectedProduct.company.name,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => _showImageSourceActionSheet(context),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: data.selectedProduct.imageUrl.isEmpty
                            ? Container(
                                height: 150,
                                child: Center(child: Text('Select Image')),
                              )
                            : Image.file(
                                File(data.selectedProduct.imageUrl),
                                fit: BoxFit.contain,
                              ),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        final price = double.parse(priceController.text);
                        productController.addProduct(
                          data.selectedProduct.copyWith(
                            name: nameController.text,
                            price: price,
                          ),
                        );
                      },
                      child: Text('Add Product'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
