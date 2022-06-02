import 'package:restaurantappp_sub2/data dan api/panggil makanan dll/resto.dart';

class RestoListPencarian{
  bool error;
  int founded;
  List<Restaurant> restaurant;

  RestoListPencarian({
    required this.error,
    required this.founded,
    required this.restaurant,});

  factory RestoListPencarian.fromJson(Map<String, dynamic> json) => RestoListPencarian(
    error: json['error'],
    founded: json['founded'],
    restaurant: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'error': error,
    'founded':founded,
    'restaurants':List<dynamic>.from(restaurant.map((x) => x.toJson()))
  };
}