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

  addToCart(FoodModel foodModel, {int quantity: 1}) async {
    try {
      var cartItem = CartModel(
          id: foodModel.id,
          name: foodModel.name,
          description: foodModel.description,
          image: foodModel.image,
          price: foodModel.price,
          addon: foodModel.addon,
          size: foodModel.size,
          quantity: quantity);
      if (isExists(cartItem)) {
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

  isExists(CartModel cartItem) =>
      cart.any((e) => e.id == cartItem.id); //to update quantity on cart screen

  sumCart() => cart.length == 0
      ? 0
      : cart
          .map((e) => e.price * e.quantity)
          .reduce((value, element) => value + element);

  getQuantity() => cart.length == 0
      ? 0
      : cart.map((e) => e.quantity).reduce((value, element) => value + element);

  getShippingFee() => sumCart() * 0.1; //10% of total price

  getSubTotal() => sumCart() + getShippingFee();

  clearCart() {
    cart.clear();
    saveDatabase();
  }

  saveDatabase() => box.write(MY_CART_KEY, jsonEncode(cart));
}
