import 'package:restaurantappp_sub2/data dan api/panggil makanan dll/resto.dart';

class RestoListRspn {
  final bool error;
  final String message;
  final int count;
  final List<Restaurant> restaurants;

  RestoListRspn({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestoListRspn.fromJson(Map<String, dynamic> json) {
    final bool error = json['error'];
    final String message = json['message'];
    final int count = json['count'];
    final List<Restaurant> restaurants = (json['restaurants'] as List)
        .map((restaurantJson) => Restaurant.fromJson(restaurantJson))
        .toList();

    return RestoListRspn(
      error: error,
      message: message,
      count: count,
      restaurants: restaurants,
    );
  }
}