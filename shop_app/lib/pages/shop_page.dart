import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/food_tile.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/models/food.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  // add food to cart
  void addFoodToCart(Food food) {
    Provider.of<Cart>(
      context,
      listen: false,
    ).addItemToCart(food);

    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text('已成功加入購物車'),
        content: Text('請檢查你的購物車'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              // search bar (no function)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '搜尋',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),

              // message
              const Padding(
                padding: EdgeInsets.all(25),
                child: Text(
                  '秉持「新鮮手作」的理念\n讓每塊炸雞擁有引以為傲的酥脆外皮、肉質多汁又鮮嫩',
                  textAlign: TextAlign.center,
                ),
              ),

              // hot picks
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '熱門精選🔥',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      '查看所有',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              // some food
              SizedBox(
                height: 650,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: value.getFoodList().length,
                  itemBuilder: (context, index) {
                    Food food = value.getFoodList()[index];

                    return FoodTile(
                      food: food,
                      onTap: () => addFoodToCart(food),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
