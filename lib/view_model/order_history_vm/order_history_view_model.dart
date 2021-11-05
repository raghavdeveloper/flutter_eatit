import 'package:flutter_eatit/model/order_model.dart';

abstract class OrderHistoryViewModel {
  Future<List<OrderModel>> getUserHistory(String restaurantId);
}
