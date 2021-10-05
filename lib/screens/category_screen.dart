import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eatit/model/category_model.dart';
import 'package:flutter_eatit/state/category_state.dart';
import 'package:flutter_eatit/state/main_state.dart';
import 'package:flutter_eatit/strings/restaurant_home_strings.dart';
import 'package:flutter_eatit/view_model/category_vm/category_viewmodel_imp.dart';
import 'package:flutter_eatit/widgets/category/category_list_widget.dart';
import 'package:flutter_eatit/widgets/common/appbar_with_cart_widget.dart';
import 'package:flutter_eatit/widgets/common/common_widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryScreen extends StatelessWidget {
  final viewModel = CategoryViewModelImp();
  final MainStateController mainStateController =
      Get.find(); //Because we already put in Main screen , so here just find
  final CategoryStateController categoryStateController = Get.put(
      CategoryStateController()); //We not put it before, so must do that
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWithCartButton(
            title: '${mainStateController.selectedRestaurant.value.name}'),
        body: FutureBuilder(
          future: viewModel.displayCategoryByRestaurantId(
              mainStateController.selectedRestaurant.value.restaurantId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            else {
              var lst = snapshot.data as List<CategoryModel>;
              return Container(
                margin: const EdgeInsets.only(top: 10),
                child: CategoryListWidget(
                  lst: lst,
                  categoryStateController: categoryStateController,
                ),
              );
            }
          },
        ));
  }
}
