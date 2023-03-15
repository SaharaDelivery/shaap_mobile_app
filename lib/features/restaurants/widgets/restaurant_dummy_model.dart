import 'package:shaap_mobile_app/utils/string_extensions.dart';

class Food {
  final String name;
  final double price;
  final String description;
  final String image;
  const Food({
    required this.name,
    required this.price,
    required this.description,
    required this.image,
  });
}

class FoodCategory {
  final String title;
  final List<Food> food;
  const FoodCategory({
    required this.title,
    required this.food,
  });
}

List<FoodCategory> foodCategories = [
  //! TOP
  FoodCategory(
    title: 'Top Sellers',
    food: [
      Food(
        name: 'Zinger Burger Combo',
        price: 4500,
        description:
            'zinger burger, 1 pc chicken, regular chips  and pepsi or water',
        image: 'food-3'.png,
      ),
      Food(
        name: 'Zinger Burger Combo',
        price: 4500,
        description:
            'zinger burger, 1 pc chicken, regular chips  and pepsi or water',
        image: 'food-3'.png,
      ),
    ],
  ),

  //! main
  FoodCategory(
    title: 'Main',
    food: [
      Food(
        name: 'Double Zinger Meal',
        price: 6500,
        description:
            'double zinger burger meal ( burger, 1pc, reg chips, pepsi',
        image: 'food-4'.png,
      ),
      Food(
        name: 'Zinger wings 10 pc',
        price: 2800,
        description: '10  pieces of hot & crispy zinger wings',
        image: 'food-5'.png,
      ),
    ],
  ),

  // wings
  FoodCategory(
    title: 'Wings & Chicken',
    food: [
      Food(
        name: 'Crispy chicken strip 8 pcs',
        price: 3500,
        description:
            'double zinger burger meal ( burger, 1pc, reg chips, pepsi',
        image: 'food-6'.png,
      ),
      Food(
        name: 'Zinger wings 8 pc',
        price: 1900,
        description: '10  pieces of hot & crispy zinger wings',
        image: 'food-5'.png,
      ),
    ],
  ),

  // fill ups
  FoodCategory(
    title: 'Fillups',
    food: [
      Food(
        name: 'Fill Up Feast',
        price: 3500,
        description:
            '1 pcs of chicken. 1 regular kfc spicy rice, 1pcs of chicken strips',
        image: 'food-8'.png,
      ),
    ],
  ),
];
