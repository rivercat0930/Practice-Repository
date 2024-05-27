import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/models/food.dart';

class CartItem extends StatefulWidget {
  final Food food;

  CartItem({
    super.key,
    required this.food,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  // remove item from cart
  void removeItemFromCart() {
    Provider.of<Cart>(
      context,
      listen: false,
    ).removeItemFromCart(widget.food);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Image.asset(widget.food.imagePath),
        title: Text(widget.food.name),
        subtitle: Text(widget.food.price),
        
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => removeItemFromCart(),
        ),
      ),
    );
  }
}
