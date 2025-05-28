import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner_plus/flutter_barcode_scanner_plus.dart';
import 'package:qrone/features/categories/category_controller.dart';
import 'package:qrone/features/categories/category_model.dart';
import 'package:qrone/features/companies/company_controller.dart';
import 'package:qrone/features/companies/company_model.dart';
import 'package:qrone/features/products/generalSelector.dart';
import 'package:qrone/features/products/product_controller.dart';
import 'package:qrone/features/products/product_model.dart';
import 'package:qrone/features/update_product/update_product_controller.dart';
import 'package:qrone/features/update_product/update_product_state.dart';
import 'package:qrone/main.dart';

class UpdateProductScreen extends StatefulWidget {
  final ProductModel selectedProduct;

  UpdateProductScreen({super.key, required this.selectedProduct});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController priceController = TextEditingController();
  final TextEditingController barcodeController = TextEditingController();

  final productController = container.get<ProductController>();
  final UpdateProductController updateController =
      container.get<UpdateProductController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    barcodeController.text = widget.selectedProduct.barCode;
    nameController.text = widget.selectedProduct.name;
    priceController.text =
        widget.selectedProduct.price.current_price.toString();

    updateController.value = updateController.value.copyWith(
      product: widget.selectedProduct.copyWith(imageUrl: ""),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('Update Product')),
    body: ValueListenableBuilder(
      valueListenable: updateController,
      builder:
          (context, data, child) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Product Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: priceController,
                    decoration: InputDecoration(
                      labelText: 'Product Price',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: barcodeController,
                    decoration: InputDecoration(
                      labelText: 'Barcode',
                      border: OutlineInputBorder(),
                      suffixIcon: GestureDetector(
                        onTap: () async {
                          final barcode =
                              await FlutterBarcodeScanner.scanBarcode(
                                '#ff6666',
                                'Cancel',
                                true,
                                ScanMode.BARCODE,
                              );
                          if (barcode != '-1') {
                            barcodeController.text = barcode;
                          }
                        },
                        child: Icon(Icons.qr_code),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a barcode';
                      }
                      if (value.length < 8) {
                        return 'Barcode must be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    validator: (value) {
                      if (data.product.category.name.isEmpty) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                    readOnly: true,
                    showCursor: false,
                    onTap: () {
                      container.get<CategoryController>().getAllCategories();
                      showModalBottomSheet(
                        context: context,
                        builder:
                            (context) => ValueListenableBuilder(
                              valueListenable:
                                  container.get<CategoryController>(),
                              builder:
                                  (context, catVal, child) =>
                                      Selector<CategoryModel>(
                                        items: catVal.categories,
                                        isLoading: catVal.isLoading,
                                        selected: data.product.category,
                                        onSelect: (CategoryModel category) {
                                          updateController.modifyProduct(
                                            data.product.copyWith(
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
                      hintText:
                          data.product.category.name.isEmpty
                              ? 'Select Category'
                              : data.product.category.name,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    validator: (value) {
                      if (data.product.company.name.isEmpty) {
                        return 'Please select a company';
                      }
                      return null;
                    },
                    readOnly: true,
                    showCursor: false,
                    onTap: () {
                      container.get<CompanyController>().getAllCompanies();
                      showModalBottomSheet(
                        context: context,
                        builder:
                            (context) => ValueListenableBuilder(
                              valueListenable:
                                  container.get<CompanyController>(),
                              builder:
                                  (context, companyValue, child) =>
                                      Selector<CompanyModel>(
                                        items: companyValue.companies,
                                        isLoading: companyValue.isLoading,
                                        selected: data.product.company,
                                        onSelect: (CompanyModel company) {
                                          updateController.modifyProduct(
                                            data.product.copyWith(
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
                      hintText:
                          data.product.company.name.isEmpty
                              ? 'Select Company'
                              : data.product.company.name,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  updateController.value.product.imageUrl.isEmpty
                      ? ElevatedButton(
                        onPressed: () {
                          updateController.pickImage();
                        },
                        child: Text('Pick Image'),
                      )
                      : Image.file(
                        File(updateController.value.product.imageUrl),
                      ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Logic to update the product
                      updateController.updateProduct(
                        barcodeController.text,
                        alternateUrl:
                            updateController.value.product.imageUrl.isEmpty
                                ? widget.selectedProduct.imageUrl
                                : "",
                        updateController.value.product.copyWith(
                          name: nameController.text,
                          price: createPriceModel(
                            current_price: double.parse(priceController.text),
                            previous_price:
                                widget.selectedProduct.price.previous_price,
                            updated_at: DateTime.now().toString(),
                            id: widget.selectedProduct.price.id,
                          ),
                        ),
                      );
                    },
                    child: Text('Update Product'),
                  ),
                ],
              ),
            ),
          ),
    ),
  );
}
