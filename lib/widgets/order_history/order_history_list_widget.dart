import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eatit/const/const.dart';
import 'package:flutter_eatit/model/order_model.dart';
import 'package:flutter_eatit/utils/utils.dart';
import 'package:flutter_eatit/widgets/common/common_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderHistoryListWidget extends StatelessWidget {
  const OrderHistoryListWidget({Key? key, required this.listOrder})
      : super(key: key);
  final List<OrderModel> listOrder;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: LiveList(
          showItemInterval: Duration(milliseconds: 300),
          showItemDuration: Duration(milliseconds: 300),
          reAnimateOnVisibility: true,
          scrollDirection: Axis.vertical,
          itemCount: listOrder.length,
          itemBuilder: animationItemBuilder((index) => InkWell(
              onTap: () {},
              child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Column(children: [
                    CachedNetworkImage(
                      imageUrl: listOrder[index].cartItemList[0].image,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, err) => Center(
                        child: Icon(Icons.image),
                      ),
                      progressIndicatorBuilder: (context, url, download) =>
                          Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            color: Color(COLOR_OVERLAY),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Order #${listOrder[index].orderNumber}',
                                                textAlign: TextAlign.center,
                                                style:
                                                    GoogleFonts.jetBrainsMono(
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: Colors.white,
                                                        fontSize: 18),
                                              ),
                                              Text(
                                                'Date ${convertToDate(listOrder[index].createdDate)}',
                                                textAlign: TextAlign.center,
                                                style:
                                                    GoogleFonts.jetBrainsMono(
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: Colors.white,
                                                        fontSize: 18),
                                              ),
                                              Text(
                                                'Order Status: ${convertStatus(listOrder[index].orderStatus)}',
                                                textAlign: TextAlign.center,
                                                style:
                                                    GoogleFonts.jetBrainsMono(
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: Colors.white,
                                                        fontSize: 18),
                                              ),
                                            ])
                                      ],
                                    ))
                              ],
                            )))
                  ])))),
        ))
      ],
    );
  }
}
