import 'package:qrone/features/companies/company_model.dart';
import 'package:qrone/state/models/immutable_list.dart';

typedef CompanyState = ({
  ImmutableList<CompanyModel> companies,
  bool isLoading,
  String error,
});
CompanyState createCompanyState({
  ImmutableList<CompanyModel> companies = const ImmutableList.empty(),
  bool isLoading = false,
  String error = '',
}) =>
    (error: error, companies: companies, isLoading: isLoading);

extension GetCompanyStateExtensions on CompanyState {
  /// Copies the login state with the given fields.
  CompanyState copyWith({
    bool? isLoading,
    ImmutableList<CompanyModel>? comapanies,
    String? error,
  }) =>
      createCompanyState(
        error: error ?? this.error,
        companies: comapanies ?? this.companies,
        isLoading: isLoading ?? this.isLoading,
      );
}
