import 'dart:convert';

import 'package:flutter_eatit/model/cart_model.dart';
import 'package:flutter_eatit/model/food_model.dart';
import 'package:flutter_eatit/strings/cart_strings.dart';
import 'package:flutter_eatit/utils/const.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartStateController extends GetxController {
  var cart = List<CartModel>.empty(growable: true).obs;
  final box = GetStorage();

  getCart(String restaurantId) =>
      cart.where((item) => item.restaurantId == restaurantId);

  addToCart(FoodModel foodModel, String restaurantId, {int quantity: 1}) async {
    try {
      var cartItem = CartModel(
        id: foodModel.id,
        name: foodModel.name,
        description: foodModel.description,
        image: foodModel.image,
        price: foodModel.price,
        addon: foodModel.addon,
        size: foodModel.size,
        quantity: quantity,
        restaurantId: restaurantId,
      );
      if (isExists(cartItem, restaurantId)) {
        //If cart item already available in cart, we will update quantity
        var foodNeedToUpdate =
            cart.firstWhere((element) => element.id == cartItem.id);
        foodNeedToUpdate.quantity += quantity;
      } else {
        cart.add(cartItem);
      }
      //After update info, we will save it to storage
      var jsonDBEncode = jsonEncode(cart);
      await box.write(MY_CART_KEY, jsonDBEncode);
      cart.refresh(); //Update
      Get.snackbar(successTitle, successMessage);
    } catch (e) {
      Get.snackbar(errorTitle, e.toString());
    }
  }

  isExists(CartModel cartItem, String restaurantId) => cart.any((e) =>
      e.id == cartItem.id &&
      e.restaurantId == restaurantId); //to update quantity on cart screen

  sumCart(String restaurantId) => getCart(restaurantId).cart.length == 0
      ? 0
      : getCart(restaurantId)
          .map((e) => e.price * e.quantity)
          .reduce((value, element) => value + element);

  getQuantity(String restaurantId) => getCart(restaurantId).length == 0
      ? 0
      : getCart(restaurantId)
          .map((e) => e.quantity)
          .reduce((value, element) => value + element);

  getShippingFee(String restaurantId) =>
      sumCart(restaurantId) * 0.1; //10% of the amount

  getSubTotal(String restaurantId) =>
      sumCart(restaurantId) + getShippingFee(restaurantId);

  clearCart(String restaurantId) {
    getCart(restaurantId).clear();
    saveDatabase();
  }

  saveDatabase() => box.write(MY_CART_KEY, jsonEncode(cart));
}
