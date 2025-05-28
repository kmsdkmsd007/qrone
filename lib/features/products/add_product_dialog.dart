import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner_plus/flutter_barcode_scanner_plus.dart';
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

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class AddProductDialog extends StatelessWidget {
  AddProductDialog({super.key}) {
    // Fetch categories when dialog opens
    categoryController.getAllCategories();
  }
  final productController = container.get<ProductController>();
  final categoryController = container.get<CategoryController>();
  final companyController = container.get<CompanyController>();

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
      builder:
          (context) => SafeArea(
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
        builder:
            (context, data, child) => Form(
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a product name';
                        }
                        if (value.length < 2) {
                          return 'Name must be at least 2 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Price',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Price must be greater than 0';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: barCodeController,
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
                              barCodeController.text = barcode;
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
                        if (data.selectedProduct.category.name.isEmpty) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                      readOnly: true,
                      showCursor: false,
                      onTap: () {
                        categoryController.getAllCategories();
                        showModalBottomSheet(
                          context: context,
                          builder:
                              (context) => ValueListenableBuilder(
                                valueListenable: categoryController,
                                builder:
                                    (context, catVal, child) =>
                                        Selector<CategoryModel>(
                                          items: catVal.categories,
                                          isLoading: catVal.isLoading,
                                          selected:
                                              productController
                                                  .value
                                                  .selectedProduct
                                                  .category,
                                          onSelect: (CategoryModel category) {
                                            productController.modifyProduct(
                                              data.selectedProduct.copyWith(
                                                category: category,
                                              ),
                                            );
                                            Navigator.pop(context);
                                          },
                                          text:
                                              (CategoryModel m) => Text(m.name),
                                        ),
                              ),
                        );
                      },
                      decoration: InputDecoration(
                        hintText:
                            data.selectedProduct.category.name.isEmpty
                                ? 'Select Category'
                                : data.selectedProduct.category.name,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      validator: (value) {
                        if (data.selectedProduct.company.name.isEmpty) {
                          return 'Please select a company';
                        }
                        return null;
                      },
                      readOnly: true,
                      showCursor: false,
                      onTap: () {
                        companyController.getAllCompanies();
                        showModalBottomSheet(
                          context: context,
                          builder:
                              (context) => ValueListenableBuilder(
                                valueListenable: companyController,
                                builder:
                                    (context, comVal, child) =>
                                        Selector<CompanyModel>(
                                          items: comVal.companies,
                                          isLoading: comVal.isLoading,
                                          selected:
                                              productController
                                                  .value
                                                  .selectedProduct
                                                  .company,
                                          onSelect: (CompanyModel company) {
                                            productController.modifyProduct(
                                              data.selectedProduct.copyWith(
                                                company: company,
                                              ),
                                            );
                                            Navigator.pop(context);
                                          },
                                          text:
                                              (CompanyModel m) => Text(m.name),
                                        ),
                              ),
                        );
                      },
                      decoration: InputDecoration(
                        hintText:
                            data.selectedProduct.company.name.isEmpty
                                ? 'Select Company'
                                : data.selectedProduct.company.name,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    FormField<String>(
                      validator: (value) {
                        // if (data.selectedProduct.imageUrl.isEmpty) {
                        //   return 'Please select an image';
                        // }
                        return null;
                      },
                      builder:
                          (FormFieldState<String> state) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap:
                                    () => _showImageSourceActionSheet(context),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          state.hasError
                                              ? Colors.red
                                              : Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child:
                                      data.selectedProduct.imageUrl.isEmpty
                                          ? Container(
                                            height: 150,
                                            child: Center(
                                              child: Text('Select Image'),
                                            ),
                                          )
                                          : Image.file(
                                            File(data.selectedProduct.imageUrl),
                                            fit: BoxFit.contain,
                                          ),
                                ),
                              ),
                              if (state.hasError)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    left: 12,
                                  ),
                                  child: Text(
                                    state.errorText!,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                    ),
                    SizedBox(height: 16),
                    ValueListenableBuilder(
                      valueListenable: productController,
                      builder:
                          (context, v, child) =>
                              v.isLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : ElevatedButton(
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        var a = await productController.addPr(
                                          data.selectedProduct.copyWith(
                                            name: nameController.text,
                                            price: createPriceModel(
                                              id: -1,
                                              updated_at: "",
                                              current_price: double.parse(
                                                priceController.text,
                                              ),
                                              previous_price: double.parse(
                                                priceController.text,
                                              ),
                                            ),
                                            barCode: barCodeController.text,
                                          ),
                                        );
                                        if (a) {
                                          barCodeController.clear();
                                          priceController.clear();
                                          nameController.clear();
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Product added successfully',
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    child: Text('Add Product'),
                                  ),
                    ),
                  ],
                ),
              ),
            ),
      ),
    ),
  );
}
