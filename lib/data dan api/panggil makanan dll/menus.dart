import 'drink.dart';
import 'food.dart';

class Menu {
  final List<Food> foods;
  final List<Drink> drinks;

  Menu({required this.foods, required this.drinks});

  factory Menu.fromJson(Map<String, dynamic> json) {
    final List<Food> foods = (json['foods'] as List)
        .map((foodJson) => Food.fromJson(foodJson))
        .toList();

    final List<Drink> drinks = (json['drinks'] as List)
        .map((drinkJson) => Drink.fromJson(drinkJson))
        .toList();

    return Menu(foods: foods, drinks: drinks);
  }
}
