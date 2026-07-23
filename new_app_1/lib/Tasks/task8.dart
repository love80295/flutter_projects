import 'package:flutter/material.dart';

class Task8 extends StatelessWidget {
  const Task8({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BurgerScreen(),
    );
  }
}

class BurgerScreen extends StatelessWidget {
  const BurgerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cheese Burger",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
      ),

      body: Center(
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 12,
                offset: Offset(3, 3),
              ),
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              // Burger Image
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  "assets/images/burger.png",
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Cheese Burger",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Fresh & Delicious Burger\nwith Cheese",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 28,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "4.8 (250 Reviews)",
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              const Text(
                "₹249",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),

                  child: const Text(
                    "Order Now",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}