import 'package:flutter_eatit/firebase/restaurant_reference.dart';
import 'package:flutter_eatit/model/restaurant_model.dart';
import 'main_view_model.dart';

class MainViewModelImp implements MainViewModel {
  @override
  Future<List<RestaurantModel>> displayRestaurantList() {
    return getRestaurantList();
  }
}
