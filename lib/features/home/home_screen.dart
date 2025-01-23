import 'package:flutter/material.dart';
import 'package:qrone/features/categories/category_controller.dart';
import 'package:qrone/features/categories/category_screen.dart';
import 'package:qrone/features/home/home_controller.dart';
import 'package:qrone/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        switch (_tabController.index) {
          case 0:
            // Products tab
            break;
          case 1:
            // Categories tab
            container.get<CategoryController>().getAllCategories();
            break;
          case 2:
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
  Widget build(BuildContext context) {
    final controller = container.get<HomeController>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
          showDialog(
      context: context,
      builder: (context) => const AddCategoryDialog(),
    );
      }),
      appBar: AppBar(
        toolbarHeight: kToolbarHeight/10,
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               
                const Text('Tab 1 Content'),
              ],
            ),
          ),
          // Second tab - Categories
            CategoryScreen(),
          // Third tab
          const Center(child: Text('Tab 3 Content')),
        ],
      ),
    );
  }
}

 