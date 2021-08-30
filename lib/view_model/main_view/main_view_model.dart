import 'package:flutter_eatit/model/restaurant_model.dart';

abstract class MainViewModel {
  Future<List<RestaurantModel>> displayRestaurantList();
}
