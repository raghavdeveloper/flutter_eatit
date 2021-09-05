import 'package:flutter_eatit/firebase/category_reference.dart';
import 'package:flutter_eatit/model/category_model.dart';
import 'package:flutter_eatit/view_model/category_vm/category_viewmodel.dart';

class CategoryViewModelImp implements CategoryViewModel {
  @override
  Future<List<CategoryModel>> displayCategoryByRestaurantId(
      String restaurantId) {
    return getCategoryByRestaurantId(restaurantId);
  }
}
