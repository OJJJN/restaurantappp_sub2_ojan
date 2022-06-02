import 'package:restaurantappp_sub2/data dan api/panggil makanan dll/resto.dart';

class RestoDetailRspn{
  bool error;
  String message;
  Restaurant restaurant;

  RestoDetailRspn({
    required this.error,
    required this.message,
    required this.restaurant
  });

  factory RestoDetailRspn.fromJson(Map<String, dynamic> json) => RestoDetailRspn(
    error: json['error'],
    message: json['message'],
    restaurant: Restaurant.fromJson(json['restaurant']),
  );

  Map<String, dynamic> toJson() => {
    'error': error,
    'message': message,
    'restaurant': restaurant,
  };
}