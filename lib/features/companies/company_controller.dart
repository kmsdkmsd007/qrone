import 'package:flutter/material.dart';
import 'package:qrone/features/companies/company_model.dart';
import 'package:qrone/features/companies/company_state.dart';
import 'package:qrone/helpers/NotifierWrapper.dart';
import 'package:qrone/state/extensions/exception_helper.dart';
import 'package:qrone/state/extensions/postgresexceptions.dart';
import 'package:qrone/state/models/immutable_list.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CompanyController extends ValueNotifier<CompanyState> {
  final GlobalKey<NavigatorState> navigatorKey;

  CompanyController({
    required this.navigatorKey,
  }) : super(createCompanyState());

  // void getAllCompanies() async {
  //   value = value.copyWith(isLoading: true);
  //   try {
  //     final a = await Supabase.instance.client.from('companies').select();

  //     ;
  //     final comapnies = a.map((e) => e.toCompanyModel()!).toList();
  //     value = value.copyWith(isLoading: false, comapanies: ~comapnies);
  //   } on PostgrestException catch (e) {
  //     value = value.copyWith(error: e.friendlyMessage, isLoading: false);
  //   }
  // }

  void addCompany(String company) async {
    try {
      value = value.copyWith(isLoading: true);

      await Supabase.instance.client
          .from('companies')
          .insert({"name": company});
      value = value.copyWith(
        isLoading: false,
      );

      getAllCompanies();
      navigatorKey.currentState?.pop();
    } on PostgrestException catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(
        SnackBar(
          content: Text(e.friendlyMessage),
        ),
      );
      value = value.copyWith(
        isLoading: false,
      );

      navigatorKey.currentState!.pop();
    }
  }

  getAllCompanies() async {
    await Supabase.instance.client.getDataList<CompanyModel>(
      tableName: "companies",
      onSuccess: (e) => value = value.copyWith(comapanies: ~e),
      fromJsonList: (f) => f.map((m) => m.toCompanyModel()!).toList(),
      query: null,
      onError: (e) => value = value.copyWith(error: e.getErrorMessage()),
      showLoading: () => value = value.copyWith(isLoading: true),
      hideLoading: () => value = value.copyWith(isLoading: false),
    );
  }
}
