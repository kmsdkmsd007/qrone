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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var controller = container.get<HomeController>();

  @override
  void initState() {
    super.initState();
    container.get<ProductController>().getAllProducts();

    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        switch (_tabController.index) {
          case 0:
            container.get<ProductController>().getAllProducts();

            controller.changeIndex(0);

            break;
          case 1:
            // Categories tab
            container.get<CategoryController>().getAllCategories();
            controller.changeIndex(1);

            break;
          case 2:
            container.get<CompanyController>().getAllCompanies();
            controller.changeIndex(2);

            // Companies tab
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, data, child) => FloatingActionButton(
            child: controller.value == 0
                ? Text('Add Product')
                : controller.value == 1
                    ? Text('Add Category')
                    : controller.value == 2
                        ? Text('Add Company')
                        : const Icon(Icons.add),
            onPressed: () {
              _tabController.index == 0
                  ? unawaited(
                      showDialog(
                        useSafeArea: false,
                        context: context,
                        builder: (context) => AddProductDialog(),
                      ),
                    )
                  : _tabController.index == 1
                      ? unawaited(
                          showDialog(
                            context: context,
                            builder: (context) => const AddCategoryDialog(),
                          ),
                        )
                      : unawaited(
                          showDialog(
                            context: context,
                            builder: (context) => const AddCompanyDialog(),
                          ),
                        );
            },
          ),
        ),
        appBar: AppBar(
          toolbarHeight: kToolbarHeight / 10,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Products', icon: Icon(Icons.shopping_cart)),
              Tab(text: 'Categories', icon: Icon(Icons.category)),
              Tab(text: 'Companies', icon: Icon(Icons.business)),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            // First tab
            ProductScreen(),
            // Second tab - Categories
            CategoryScreen(),
            // Third tab
            CompanyScreen(),
          ],
        ),
      );
}
