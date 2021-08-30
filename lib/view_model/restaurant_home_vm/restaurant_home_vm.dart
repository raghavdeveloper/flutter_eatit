import 'package:flutter_eatit/model/popular_item_model.dart';

abstract class RestaurantHomeViewModel {
  Future<List<PopularItemModel>> displayMostPopularByRestaurantId(
      String restaurantId);

  Future<List<PopularItemModel>> displayBestDealsByRestaurantId(
      String restaurantId);
}
