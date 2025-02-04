typedef CategoryModel = ({int id, String name});

CategoryModel productAttribute({
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
