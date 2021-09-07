import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eatit/const/const.dart';
import 'package:flutter_eatit/state/category_state.dart';
import 'package:flutter_eatit/state/food_list_state.dart';
import 'package:flutter_eatit/strings/food_list_string.dart';
import 'package:flutter_eatit/utils/utils.dart';
import 'package:flutter_eatit/widgets/common/common_widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodDetailScreen extends StatelessWidget {
  final CategoryStateController categoryStateController = Get.find();
  final FoodListStateController foodListStateController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
              title: Text("${foodListStateController.selectedFood.value.name}",
                  style: GoogleFonts.jetBrainsMono(color: Colors.black)),
              elevation: 10,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              foregroundColor: Colors.black,
              bottom: PreferredSize(
                  preferredSize: Size.square(foodDetailsImageAreaSize(context)),
                  child: Column(children: [
                    Container(
                      width: double.infinity, //max width
                      height: foodDetailsImageAreaSize(context) * 0.9,
                      child: CachedNetworkImage(
                          imageUrl:
                              foodListStateController.selectedFood.value.image,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, err) => Center(
                                child: Icon(Icons.image),
                              ),
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                                    child: CircularProgressIndicator(),
                                  )),
                    )
                  ])))
        ];
      },
      body: Container(),
    )));
  }
}
