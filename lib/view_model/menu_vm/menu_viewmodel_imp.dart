import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_auth_ui/flutter_auth_ui.dart';
import 'package:flutter_eatit/screens/cart_screen.dart';
import 'package:flutter_eatit/screens/category_screen.dart';
import 'package:flutter_eatit/screens/restaurant_home.dart';
import 'package:flutter_eatit/state/cart_state.dart';
import 'package:flutter_eatit/state/main_state.dart';
import 'package:flutter_eatit/strings/main_strings.dart';
import 'package:flutter_eatit/utils/const.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'menu_view_model.dart';

class MenuViewModelImp implements MenuViewModel {
  final cartState = Get.put(CartStateController());
  final mainState = Get.put(MainStateController());

  @override
  void navigateCategories() {
    Get.to(() => CategoryScreen());
  }

  @override
  void backToRestaurantList() {
    Get.back(closeOverlays: true, canPop: false);
  }

  @override
  bool checkLoginState(BuildContext context) {
    return FirebaseAuth.instance.currentUser != null ? true : false;
  }

  @override
  void login(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      FlutterAuthUi.startUi(
              items: [AuthUiProvider.phone],
              tosAndPrivacyPolicy: TosAndPrivacyPolicy(
                  tosUrl: 'https://google.com',
                  privacyPolicyUrl: 'https://youtube.com'),
              androidOption: AndroidOption(
                  enableSmartLock: false, showLogo: true, overrideTheme: true))
          .then((value) async {
        navigationHome(context);
      }).catchError((e) {
        Get.snackbar('Error', '$e');
      });
    }
  }

  @override
  void logout(BuildContext context) {
    Get.defaultDialog(
      title: logoutTitle,
      content: Text(logoutText),
      backgroundColor: Colors.white,
      cancel:
          ElevatedButton(onPressed: () => Get.back(), child: Text(cancelText)),
      confirm: ElevatedButton(
          onPressed: () {
            FirebaseAuth.instance
                .signOut()
                .then((value) => Get.offAll(RestaurantHome()));
          },
          child: Text(confirmText, style: TextStyle(color: Colors.yellow))),
    );
  }

  @override
  void navigationHome(BuildContext context) async {
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();
    var box = GetStorage();
    //Save token, use for send notification
    box.write(KEY_TOKEN, token);
    //Clone cart
    if (cartState.cart.length > 0) //if not empty
    {
      var newCart = cartState.getCartAnonymous(mainState
          .selectedRestaurant
          .value
          .restaurantId); //remember get only Anonymous if forgot, it will clone all accout cart
      cartState.mergeCart(
          newCart, mainState.selectedRestaurant.value.restaurantId);
      cartState.saveDatabase(); //save
    }
    Get.offAll(() => RestaurantHome());
  }

  @override
  void navigateCart() => Get.to(() => CartDetailScreen());
}
