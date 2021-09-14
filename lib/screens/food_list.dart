import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eatit/const/const.dart';
import 'package:flutter_eatit/state/category_state.dart';
import 'package:flutter_eatit/state/food_list_state.dart';
import 'package:flutter_eatit/strings/food_list_string.dart';
import 'package:flutter_eatit/widgets/common/appbar_with_cart_widget.dart';
import 'package:flutter_eatit/widgets/common/common_widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'food_details.dart';

class FoodListScreen extends StatelessWidget {
  final CategoryStateController categoryStateController = Get.find();
  final FoodListStateController foodListStateController =
      Get.put(FoodListStateController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWithCartButton(
          title: '${categoryStateController.selectedCategory.value.name}',
        ),
        body: Column(children: [
          Expanded(
              child: LiveList(
            showItemInterval: Duration(milliseconds: 300),
            showItemDuration: Duration(milliseconds: 300),
            reAnimateOnVisibility: true,
            scrollDirection: Axis.vertical,
            itemCount:
                categoryStateController.selectedCategory.value.foods.length,
            itemBuilder: animationItemBuilder((index) => InkWell(
                  onTap: () {
                    //Assign to state
                    foodListStateController.selectedFood.value =
                        categoryStateController
                            .selectedCategory.value.foods[index];
                    Get.to(() => FoodDetailScreen());
                  },
                  child: Hero(
                      tag: categoryStateController
                          .selectedCategory.value.foods[index].name,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 6 * 2,
                        child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                CachedNetworkImage(
                                    imageUrl: categoryStateController
                                        .selectedCategory
                                        .value
                                        .foods[index]
                                        .image,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, err) => Center(
                                          child: Icon(Icons.image),
                                        ),
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        Center(
                                          child: CircularProgressIndicator(),
                                        )),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                        color: Color(COLOR_OVERLAY),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20, bottom: 20),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                                '${categoryStateController.selectedCategory.value.foods[index].name}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GoogleFonts
                                                                    .jetBrainsMono(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            18)),
                                                            Text(
                                                                '$priceText: \$${categoryStateController.selectedCategory.value.foods[index].price}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GoogleFonts
                                                                    .jetBrainsMono(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            18)),
                                                            Row(children: [
                                                              IconButton(
                                                                onPressed:
                                                                    () {},
                                                                icon: Icon(
                                                                    Icons
                                                                        .favorite_border,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              SizedBox(
                                                                  width: 50),
                                                              IconButton(
                                                                onPressed:
                                                                    () {},
                                                                icon: Icon(
                                                                    Icons
                                                                        .add_shopping_cart,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ])
                                                          ])
                                                    ]),
                                              )
                                            ])))
                              ],
                            )),
                      )),
                )),
          ))
        ]));
  }
}
