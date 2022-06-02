import 'package:restaurantappp_sub2/cons/constants.dart';
import 'menus.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String address;
  final num rating;
  final Menu menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.address,
    required this.rating,
    required this.menus,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    final String id = json['id'];
    final String name = json['name'];
    final String description = json['description'];
    final String pictureId = json['pictureId'];
    final String city = json['city'];
    final String address = json['address'] ?? "";
    final num rating = json['rating'];
    final Menu menus = json['menus'] != null
        ? Menu.fromJson(json['menus'])
        : Menu(foods: [], drinks: []);


    return Restaurant(
      id: id,
      name: name,
      description: description,
      pictureId: pictureId,
      city: city,
      address: address,
      rating: rating,
      menus: menus,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "pictureId": pictureId,
    "city": city,
    "address": address,
    "rating": rating,
  };

  String get smallPictureUrl => '$baseUrl/images/small/$pictureId';

  String get mediumPictureUrl => '$baseUrl/images/medium/$pictureId';

  String get largePictureUrl => '$baseUrl/images/large/$pictureId';
}