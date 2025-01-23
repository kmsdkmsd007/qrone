import 'package:qrone/features/categories/category_model.dart';
import 'package:qrone/state/models/immutable_list.dart';

typedef CategoryState = ({
 ImmutableList<CategoryModel> categories,
 bool isLoading,
 String error,
 AddCategoryState addCategoryState
});
CategoryState createCategoryState({
 ImmutableList<CategoryModel> categories=  const ImmutableList.empty(),
 bool isLoading=false,
 String error=''
 ,
 AddCategoryState  addCategoryState= const (isAdded: false, isLoading: false, error: '',)
}) =>
    ( addCategoryState: addCategoryState,  error: error, categories: categories, isLoading: isLoading);

extension GetCategoryStateExtensions on CategoryState {
  /// Copies the login state with the given fields.
  CategoryState copyWith({
   bool? isLoading,
    ImmutableList<CategoryModel>? categories,
    String? error,
    AddCategoryState? addState
  }) =>
      createCategoryState(
        error: error??this.error,
        addCategoryState: addState??this.addCategoryState,
        categories: categories ?? this.categories,
        isLoading: isLoading ?? this.isLoading,
      );
}








 
typedef AddCategoryState = ({
 bool isLoading,
 bool isAdded,
 String error,
});
AddCategoryState createAddCategoryState({
 bool isLoading=false,
 bool isAdded=false,
 String error=''
}) =>
    (  error: error,isAdded:isAdded, isLoading: isLoading);

extension AddCategoryStateExtensions on AddCategoryState {
  /// Copies the login state with the given fields.
  AddCategoryState copyWith({
   bool? isLoading,
   bool? isAdded,
   
    String? error
  }) =>
      createAddCategoryState(
        error: error??this.error,
        isAdded: isAdded??this.isAdded,
        isLoading: isLoading ?? this.isLoading,
      );
}

