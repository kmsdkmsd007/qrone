import 'package:flutter/material.dart';
import 'package:qrone/features/companies/company_controller.dart';
import 'package:qrone/main.dart';

class CompanyScreen extends StatelessWidget {
  CompanyScreen({super.key});
  final controller = container.get<CompanyController>();

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, value, child) => value.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : value.error.isNotEmpty
                ? Center(
                    child: Text(value.error),
                  )
                : ListView.builder(
                    itemCount: value.companies.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(value.companies[index].name),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ),
                  ),
      );
}

class AddCompanyDialog extends StatefulWidget {
  const AddCompanyDialog({super.key});

  @override
  State<AddCompanyDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCompanyDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: container.get<CompanyController>(),
        builder: (context, data, child) => AlertDialog(
          title: const Text('Add New Company'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Company Name',
                hintText: 'Enter company name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a company name';
                }
                return null;
              },
            ),
          ),
          actions: [
            data.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            container
                                .get<CompanyController>()
                                .addCompany(_nameController.text);
                          }
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  ),
          ],
        ),
      );
}
