import 'package:flutter_eatit/state/cart_state.dart';

abstract class CartViewModel {
  void updateCart(CartStateController controller, int index, int value);
}
