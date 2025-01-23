typedef CategoryModel = ({int id, String name});

CategoryModel productAttribute({
  required int id,
  required String name,
}) =>
    (id: id, name: name);

extension ProductAttributeExtensions on CategoryModel {
  CategoryModel copyWith({int? id, String? name}) => (
        id: id ?? this.id,
        name: name ?? this.name,
      );

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
extension CategoryModelJson on Map<String, dynamic> {
  CategoryModel? toProductAttribute() => switch (this) {
        {
          'id': final int id,
          'title': final String name,
        } =>
          (id: id, name: name),
        _ => null
      };
}
