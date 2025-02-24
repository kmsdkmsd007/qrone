import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qrone/features/categories/category_controller.dart';
import 'package:qrone/features/categories/category_screen.dart';
import 'package:qrone/features/companies/company_controller.dart';
import 'package:qrone/features/companies/company_screen.dart';
import 'package:qrone/features/home/home_controller.dart';
import 'package:qrone/features/products/add_product_dialog.dart';
import 'package:qrone/features/products/product_controller.dart';
import 'package:qrone/features/products/product_screen.dart';
import 'package:qrone/main.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  var controller = container.get<HomeController>();

  final PageController _pageController = PageController();

  // @override
  // void initState() {
  //   super.initState();
  //   container.get<ProductController>().getAllProducts();
  // }

  // @override
  // void dispose() {
  //   _pageController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    container.get<ProductController>().getAllProducts();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withOpacity(0.8),
              ],
            ),
          ),
        ),
        title: ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, index, _) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                index == 0
                    ? Icons.shopping_cart
                    : index == 1
                        ? Icons.category
                        : Icons.business,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                index == 0
                    ? 'Products'
                    : index == 1
                        ? 'Categories'
                        : 'Companies',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Add search functionality later
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          controller.changeIndex(index);
          _handleTabChange(index);
        },
        children: [
          ProductScreen(),
          CategoryScreen(),
          CompanyScreen(),
        ],
      ),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, index, _) => FloatingActionButton.extended(
          backgroundColor: Theme.of(context).primaryColor,
          icon: Icon(
            index == 0
                ? Icons.add_shopping_cart
                : index == 1
                    ? Icons.category_outlined
                    : Icons.business_center_outlined,
            color: Colors.white,
          ),
          label: Text(
            index == 0
                ? 'Add Product'
                : index == 1
                    ? 'Add Category'
                    : 'Add Company',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 4,
          onPressed: () => _handleFabPress(context, index),
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, currentIndex, _) => BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Products',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Companies',
            ),
          ],
        ),
      ),
    );
  }

  void _handleTabChange(int index) {
    switch (index) {
      case 0:
        container.get<ProductController>().getAllProducts();
        break;
      case 1:
        container.get<CategoryController>().getAllCategories();
        break;
      case 2:
        container.get<CompanyController>().getAllCompanies();
        break;
    }
  }

  void _handleFabPress(BuildContext context, int index) {
    if (index == 0) {
      unawaited(
        showDialog(
          useSafeArea: false,
          context: context,
          builder: (context) => AddProductDialog(),
        ),
      );
    } else if (index == 1) {
      unawaited(
        showDialog(
          context: context,
          builder: (context) => const AddCategoryDialog(),
        ),
      );
    } else {
      unawaited(
        showDialog(
          context: context,
          builder: (context) => const AddCompanyDialog(),
        ),
      );
    }
  }
}
