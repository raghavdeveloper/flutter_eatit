import 'dart:ui';

import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eatit/model/popular_item_model.dart';
import 'package:flutter_eatit/state/main_state.dart';
import 'package:flutter_eatit/strings/restaurant_home_strings.dart';
import 'package:flutter_eatit/view_model/restaurant_home_vm/restaurant_home_vm.dart';
import 'package:flutter_eatit/view_model/restaurant_home_vm/restaurant_home_vm_imp.dart';
import 'package:flutter_eatit/widgets/common/common_widgets.dart';
import 'package:flutter_eatit/widgets/restaurant_home/best_deal_widget.dart';
import 'package:flutter_eatit/widgets/restaurant_home/most_popular_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantHome extends StatelessWidget {
  final MainStateController mainStateController = Get.find();
  final RestaurantHomeViewModel viewModel = RestaurantHomeViewModelImp();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          '${mainStateController.selectedRestaurant.value.name}',
          style: GoogleFonts.jetBrainsMono(
              color: Colors.black, fontWeight: FontWeight.w900),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 10,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: MostPopularWidget(
                  viewModel: viewModel,
                  mainStateController: mainStateController),
            ),
            Expanded(
              flex: 2,
              child: BestDealWidget(
                  viewModel: viewModel,
                  mainStateController: mainStateController),
            ),
          ],
        ),
      ),
    ));
  }
}
