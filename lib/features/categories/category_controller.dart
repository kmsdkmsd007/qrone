import 'package:flutter/material.dart';
import 'package:qrone/features/categories/category_model.dart';
import 'package:qrone/features/categories/category_state.dart';
import 'package:qrone/features/login/login_state.dart';
import 'package:qrone/navigation/navigations.dart';
import 'package:qrone/services/auth_service.dart';
import 'package:qrone/state/models/immutable_list.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryController extends ValueNotifier<CategoryState> {
  final GlobalKey<NavigatorState> navigatorKey;
  final AuthService _authService;

  CategoryController({
    required this.navigatorKey,
    required AuthService authService,
  })  : _authService = authService,
        super(createCategoryState());


        void getAllCategories() async{
          value = value.copyWith(isLoading: true);
          // Call the API to get all categories
          // Once the API call is done, update the state
          try{
          var a=await Supabase.instance.client.from('categories').select();
 
;          var categories =a.map((e) => e.toProductAttribute()!).toList();
          value = value.copyWith(isLoading: false, categories: ~categories);
          }
          catch(e){
            value=value.copyWith(error: e.toString());
          }

        }
  

addCategory(String category)async{
  try{
    value=value.copyWith(addState: value.addCategoryState.copyWith(isLoading: true, isAdded: false));
    
 await Supabase.instance.client.from('categories').insert({"title":category});
    value=value.copyWith(addState: value.addCategoryState.copyWith(isLoading: false, isAdded: true));

 getAllCategories();
 navigatorKey.currentState?.pop();
 
  }catch(e){
  value=  value.copyWith(addState: value.addCategoryState.copyWith(error: e.toString()));
  }

}
  

}