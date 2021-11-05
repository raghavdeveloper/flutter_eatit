import 'package:flutter/material.dart';
import 'package:flutter_eatit/model/order_model.dart';
import 'package:flutter_eatit/state/main_state.dart';
import 'package:flutter_eatit/strings/main_strings.dart';
import 'package:flutter_eatit/view_model/order_history_vm/order_history_view_model_imp.dart';
import 'package:flutter_eatit/widgets/order_history/order_history_list_widget.dart';
import 'package:get/get.dart';

class OrderHistory extends StatelessWidget {
  final vm = new OrderHistoryViewModelImp();
  final MainStateController mainStateController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text(orderHistoryText)),
      body: FutureBuilder(
          future: vm.getUserHistory(
              mainStateController.selectedRestaurant.value.restaurantId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            else {
              var lst = snapshot.data as List<OrderModel>;
              return OrderHistoryListWidget(listOrder: lst);
            }
          }),
    ));
  }
}
