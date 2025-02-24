typedef CompanyModel = ({int id, String name});

CompanyModel companyModel({
  required int id,
  required String name,
}) =>
    (id: id, name: name);

extension CompanyModelExtension on CompanyModel {
  Map<String, dynamic> toMap() => {'name': name};

  CompanyModel copyWith({int? id, String? name}) => (
        id: id ?? this.id,
        name: name ?? this.name,
      );

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

extension CompanyModelJson on Map<String, dynamic> {
  CompanyModel? toCompanyModel() => switch (this) {
        {
          'id': final int id,
          'name': final String name,
        } =>
          (id: id, name: name),
        _ => null
      };
}
