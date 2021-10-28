import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_eatit/model/cart_model.dart';
import 'package:flutter_eatit/screens/place_order_screen.dart';
import 'package:flutter_eatit/state/cart_state.dart';
import 'package:flutter_eatit/state/main_state.dart';
import 'package:flutter_eatit/view_model/menu_vm/menu_viewmodel_imp.dart';
import 'package:get/get.dart';

import 'cart_view_model.dart';

class CartViewModelImp implements CartViewModel {
  final MainStateController mainStateController = Get.find();
  final MenuViewModelImp menuViewModelImp = new MenuViewModelImp();

  void updateCart(CartStateController controller, String restaurantId,
      int index, int value) {
    //Update quantity
    controller.cart.value = controller.getCart(restaurantId);
    controller.cart[index].quantity = value;
    controller.cart.refresh();
    controller.saveDatabase();
  }

  void deleteCart(
      CartStateController controller, String restaurantId, int index) {
    controller.cart.value = controller.getCart(restaurantId);
    controller.cart.removeAt(index);
    controller.saveDatabase();
  }

  void clearCart(CartStateController controller) {
    controller
        .clearCart(mainStateController.selectedRestaurant.value.restaurantId);
  }

  @override
  processCheckout(BuildContext context, List<CartModel> cart) {
    if (FirebaseAuth.instance.currentUser != null) {
      //Business of checkout
      Get.to(() => PlaceOrderScreen());
    } else {
      menuViewModelImp.login(context);
    }
  }
}
