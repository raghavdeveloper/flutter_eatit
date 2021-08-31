import 'package:flutter_eatit/screens/category_screen.dart';
import 'package:get/get.dart';


import 'menu_view_model.dart';

class MenuViewModelImp implements MenuViewModel {
  @override
  void navigateCategories() {
    Get.to(() => CategoryScreen());
  }
}
