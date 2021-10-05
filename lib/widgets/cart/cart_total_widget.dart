import 'package:flutter/material.dart';
import 'package:flutter_eatit/state/cart_state.dart';
import 'package:flutter_eatit/strings/cart_strings.dart';
import 'package:flutter_eatit/utils/utils.dart';
import 'package:flutter_eatit/widgets/cart/cart_total_item_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalWidget extends StatelessWidget {
  const TotalWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final CartStateController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 12,
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              TotalItemWidget(
                text: totalText,
                value: currencyFormat.format(controller.sumCart()),
                isSubTotal: false,
              ),
              Divider(
                thickness: 2,
              ),
              TotalItemWidget(
                text: shippingFeeText,
                value: currencyFormat.format(controller.getShippingFee()),
                isSubTotal: false,
              ),
              Divider(
                thickness: 2,
              ),
              TotalItemWidget(
                text: subTotalText,
                value: currencyFormat.format(controller.getSubTotal()),
                isSubTotal: true,
              ),
            ])));
  }
}
