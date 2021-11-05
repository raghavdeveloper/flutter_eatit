import 'package:flutter_eatit/firebase/order_reference.dart';
import 'package:flutter_eatit/model/order_model.dart';

import 'order_history_view_model.dart';

class OrderHistoryViewModelImp implements OrderHistoryViewModel {
  @override
  Future<List<OrderModel>> getUserHistory(String restaurantId) {
    return getUserOrderByRestaurant(restaurantId);
  }
}
