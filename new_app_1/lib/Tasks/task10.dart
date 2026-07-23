import 'package:flutter/material.dart';

class Task10 extends StatelessWidget {
  const Task10({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FoodScreen(),
    );
  }
}
class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ListView Example",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: const [
          FoodCard(
            icon: Icons.lunch_dining,
            name: "Cheese Burger",
            price: "₹149",
          ),
          Divider(),
          FoodCard(
            icon: Icons.local_pizza,
            name: "Veg Pizza",
            price: "₹199",
          ),
          Divider(),
          FoodCard(
            icon: Icons.ramen_dining,
            name: "Pasta",
            price: "₹179",
          ),
          Divider(),
          FoodCard(
            icon: Icons.breakfast_dining,
            name: "Sandwich",
            price: "₹99",
          ),
          Divider(),
          FoodCard(
            icon: Icons.local_drink,
            name: "Cold Drink",
            price: "₹49",
          ),
          Divider(),
          FoodCard(
            icon: Icons.icecream,
            name: "Ice Cream",
            price: "₹69",
          ),
          Divider(),
          FoodCard(
            icon: Icons.cake,
            name: "Chocolate Cake",
            price: "₹149",
          ),
        ],
      ),
    );
  }
}
class FoodCard extends StatelessWidget {
  final IconData icon;
  final String name;
  final String price;

  const FoodCard({
    super.key,
    required this.icon,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: Icon(
          icon,
          size: 45,
          color: Colors.orange,
        ),

        title: Text(
          name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(
          price,
          style: TextStyle(fontSize: 16),
        ),

        trailing: Icon(
          Icons.shopping_cart,
          color: Colors.green,
          size: 30,
        ),
      ),
    );
  }
}