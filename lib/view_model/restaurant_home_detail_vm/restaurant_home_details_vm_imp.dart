import 'package:flutter_eatit/firebase/best_deal_reference.dart';
import 'package:flutter_eatit/firebase/popular_reference.dart';
import 'package:flutter_eatit/model/popular_item_model.dart';
import 'package:flutter_eatit/view_model/restaurant_home_detail_vm/restaurant_home_details_vm.dart';

class RestaurantHomeDetailsViewModelImp
    implements RestaurantHomeDetailsViewModel {
  @override
  Future<List<PopularItemModel>> displayMostPopularByRestaurantId(
      String restaurantId) {
    return getMostPopularByRestaurantId(restaurantId);
  }

  @override
  Future<List<PopularItemModel>> displayBestDealsByRestaurantId(
      String restaurantId) {
    return getBestDealByRestaurantId(restaurantId);
  }
}
