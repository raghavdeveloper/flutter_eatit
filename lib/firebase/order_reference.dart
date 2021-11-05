import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_eatit/const/const.dart';
import 'package:flutter_eatit/model/order_model.dart';

Future<bool> writeOrderToFirebase(OrderModel orderModel) async {
  try {
    await FirebaseDatabase.instance
        .reference()
        .child(RESTAURANT_REF)
        .child(orderModel.restaurantId)
        .child(ORDER_REF)
        .child(orderModel.orderNumber)
        .set(orderModel.toJson());
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<List<OrderModel>> getUserOrderByRestaurant(String restaurantId) async {
  var userId = FirebaseAuth.instance.currentUser?.uid;
  var list = new List<OrderModel>.empty(growable: true);
  var source = await FirebaseDatabase.instance
      .reference()
      .child(RESTAURANT_REF)
      .child(restaurantId)
      .child(ORDER_REF)
      .orderByChild('userId')
      .equalTo(userId)
      .once();
  Map<dynamic, dynamic> values = source.value;
  values.forEach((key, value) {
    list.add(OrderModel.fromJson(jsonDecode(jsonEncode(value))));
  });
  return list;
}
