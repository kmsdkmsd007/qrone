import 'package:flutter/material.dart';
import 'package:qrone/features/categories/category_controller.dart';
import 'package:qrone/main.dart';

class CategoryScreen extends StatelessWidget {
    CategoryScreen({super.key});
  final controller= container.get<CategoryController>()
  
  ;

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) {
        return value.isLoading?Center(child: CircularProgressIndicator(),): 
        value.error.isNotEmpty?Center(child: Text(value.error),):
            ListView.builder(
                itemCount: value.categories.length,  
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text(value.categories[index].name),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                      
                      },
                    ),
                  );
                },
        );
      }
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddCategoryDialog(),
    );
  }
}

class AddCategoryDialog extends StatefulWidget {
  const AddCategoryDialog({super.key});

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: container.get<CategoryController>(),
      builder: (context, data, child) {
        return AlertDialog(
          title: const Text('Add New Category'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Category Name',
                hintText: 'Enter category name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a category name';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            data.addCategoryState.isLoading?Center(child: CircularProgressIndicator(),):
            data.addCategoryState.error.isNotEmpty?Center(child: Text(data.addCategoryState.error),):
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  container.get<CategoryController>().addCategory(_nameController.text);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      }
    );
  }
}
