typedef CategoryModel = ({int id, String name});

CategoryModel categoryModel({
  required int id,
  required String name,
}) =>
    (id: id, name: name);

extension CategoryModelJson on Map<String, dynamic> {
  CategoryModel? toCategoryModel() => switch (this) {
        {
          'id': final int id,
          'title': final String name,
        } =>
          (id: id, name: name),
        _ => null
      };
}

extension CategoryModelToJson on CategoryModel {
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': name,
      };
}
