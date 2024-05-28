import 'package:e_commerce_app/models/product.dart';
import 'package:flutter/material.dart';

class Shop extends ChangeNotifier {
  // products for sale
  final List<Product> _shop = [
    // product 1
    Product(
      name: '米漿',
      price: 12.4,
      description: '好喝的米漿',
      //imagePath: imagePath,
    ),
    // product 1
    Product(
      name: '米漿1',
      price: 13.4,
      description: '好喝的米漿',
      //imagePath: imagePath,
    ),
    // product 1
    Product(
      name: '米漿2',
      price: 14.4,
      description: '好喝的米漿',
      //imagePath: imagePath,
    ),
    // product 1
    Product(
      name: '米漿3',
      price: 15.4,
      description: '好喝的米漿',
      //imagePath: imagePath,
    ),
    // product 1
    Product(
      name: '米漿4',
      price: 16.4,
      description: '好喝的米漿',
      //imagePath: imagePath,
    ),
  ];

  // user cart
  List<Product> _cart = [];

  // get product list
  List<Product> get shop => _shop;

  // get user cart
  List<Product> get cart => _cart;

  // add item to cart
  void addToCart(Product product) {
    _cart.add(product);
    notifyListeners();
  }

  // remove item from cart
  void removeFromCart(Product product) {
    _cart.remove(product);
    notifyListeners();
  }
}
