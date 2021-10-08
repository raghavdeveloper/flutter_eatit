import 'package:flutter_eatit/state/cart_state.dart';
import 'package:flutter_eatit/state/main_state.dart';
import 'package:get/get.dart';

import 'cart_view_model.dart';

class CartViewModelImp implements CartViewModel {
  final MainStateController mainStateController = Get.find();

  void updateCart(CartStateController controller, int index, int value) {
    //Update quantity
    controller.cart[index].quantity = value;
    controller.cart.refresh();
    controller.saveDatabase();
  }

  void deleteCart(CartStateController controller, int index) {
    controller.cart.removeAt(index);
    controller.saveDatabase();
  }

  void clearCart(CartStateController controller) {
    controller
        .clearCart(mainStateController.selectedRestaurant.value.restaurantId);
  }
}
