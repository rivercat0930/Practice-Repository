import 'package:flutter/material.dart';
import 'package:shop_app/models/food.dart';

class Cart extends ChangeNotifier {
  // list of food for sale
  List<Food> foodShop = [
    Food(
      name: '青花椒狂嗑桶',
      price: '404',
      imagePath: 'lib/images/青花椒狂嗑桶.jpeg',
      description: '青花椒香麻脆雞x5\n雙色轉轉QQ球x1\n原味蛋撻x2\n冰檸檬紅茶(小)x2',
    ),
    Food(
      name: '青花椒香麻脆雞分享餐',
      price: '549',
      imagePath: 'lib/images/青花椒香麻脆雞分享餐.jpeg',
      description: '青花椒香麻脆雞x3\n咔啦脆雞x3\n原味蛋撻禮盒x1\n百事可樂(小)x3',
    ),
    Food(
      name: '青花椒香麻脆雞 絕配餐',
      price: '201',
      imagePath: 'lib/images/青花椒麻雞-絕配餐.jpeg',
      description: '青花椒香麻脆雞x2\n香酥脆薯(小)x1\n百事可樂(中)x1\n原味蛋撻x1',
    ),
    Food(
      name: '青花椒香麻咔啦雞腿堡雙人餐',
      price: '386',
      imagePath: 'lib/images/青花椒香麻咔啦雞腿堡雙人餐.jpeg',
      description:
          '青花椒香麻咔啦雞腿堡x1\n青花椒香麻脆雞x2\n香酥脆薯(中)x1\n4塊上校雞塊x1\n雙色轉轉QQ球X1\n百事可樂(中)x2',
    ),
  ];

  // list of items in user cart
  List<Food> userCart = [];

  // get list of food for sale
  List<Food> getFoodList() {
    return foodShop;
  }

  // get cart
  List<Food> getUserCart() {
    return userCart;
  }

  // add items to cart
  void addItemToCart(Food food) {
    userCart.add(food);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(Food food) {
    userCart.remove(food);
    notifyListeners();
  }
}
