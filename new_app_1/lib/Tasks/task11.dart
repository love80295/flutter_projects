// ============================================
// FILE: lib/task/task6.dart
// TASK 6: COMPLETE SMART CAFE APPLICATION
// ============================================

import 'package:flutter/material.dart';

class SmartCafeApp extends StatefulWidget {
  const SmartCafeApp({super.key});

  @override
  State<SmartCafeApp> createState() => _SmartCafeAppState();
}

class _SmartCafeAppState extends State<SmartCafeApp> {
  // Menu Data
  final Map<String, List<MenuItem>> menuData = {
    'Burger': [
      MenuItem('Veg Burger', 'Delicious veg burger with fresh veggies and cheese.', 120),
      MenuItem('Chicken Burger', 'Grilled chicken with lettuce and mayo.', 150),
      MenuItem('Double Cheese Burger', 'Double patty with extra cheese.', 180),
    ],
    'Pizza': [
      MenuItem('Margherita', 'Classic tomato sauce with mozzarella.', 200),
      MenuItem('Pepperoni', 'Pepperoni with extra cheese.', 250),
      MenuItem('Veggie Supreme', 'Loaded with fresh vegetables.', 220),
    ],
    'Cold Coffee': [
      MenuItem('Iced Latte', 'Smooth espresso with cold milk.', 80),
      MenuItem('Frappe', 'Blended coffee with ice.', 90),
      MenuItem('Mocha', 'Chocolate coffee blend.', 100),
    ],
    'French Fries': [
      MenuItem('Classic Fries', 'Crispy golden fries.', 70),
      MenuItem('Cheese Fries', 'Loaded with cheese sauce.', 90),
      MenuItem('Spicy Fries', 'With chili and herbs.', 80),
    ],
  };

  String selectedCategory = 'Burger';
  MenuItem? selectedItem;
  int quantity = 1;
  bool isOrderPlaced = false;
  bool showSpecial = false;
  bool addCheese = false;
  bool extraSauce = false;

  @override
  void initState() {
    super.initState();
    selectedItem = menuData[selectedCategory]?.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Smart Café',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Navigating back...'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            tooltip: 'Go Back',
          ),
        ],
      ),
      body: isOrderPlaced
          ? _buildOrderSuccessScreen()
          : _buildMainScreen(),
    );
  }

  Widget _buildMainScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Dropdown
          _buildCategoryDropdown(),
          const SizedBox(height: 20),

          // Selected Item
          if (selectedItem != null) _buildSelectedItemCard(),
          const SizedBox(height: 20),

          // Quantity Control
          _buildQuantityControl(),
          const SizedBox(height: 20),

          // Action Buttons
          _buildActionButtons(),
          const SizedBox(height: 20),

          // Today's Special
          _buildTodaySpecial(),
        ],
      ),
    );
  }

  // ============================================
  // DROPDOWN BUTTON - Category Selection
  // ============================================
  Widget _buildCategoryDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCategory,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.orange),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          items: menuData.keys.map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Row(
                children: [
                  Icon(
                    _getCategoryIcon(category),
                    color: Colors.orange,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(category),
                ],
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedCategory = newValue;
                selectedItem = menuData[newValue]?.first;
                quantity = 1;
                addCheese = false;
                extraSauce = false;
              });
            }
          },
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Burger':
        return Icons.fastfood;
      case 'Pizza':
        return Icons.local_pizza;
      case 'Cold Coffee':
        return Icons.coffee;
      case 'French Fries':
        return Icons.restaurant;
      default:
        return Icons.restaurant_menu;
    }
  }

  // ============================================
  // SELECTED ITEM CARD
  // ============================================
  Widget _buildSelectedItemCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    selectedItem!.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '₹${selectedItem!.price}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              selectedItem!.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),

            // Checkbox Buttons - Add-ons
            const Text(
              'Add-ons:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: const Text('Add Cheese'),
                    value: addCheese,
                    onChanged: (bool? value) {
                      setState(() {
                        addCheese = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: const Text('Extra Sauce'),
                    value: extraSauce,
                    onChanged: (bool? value) {
                      setState(() {
                        extraSauce = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Text Buttons
            Wrap(
              spacing: 8,
              children: [
                TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Nutrition info for ${selectedItem!.name}'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.info_outline, size: 18),
                  label: const Text('View Nutrition'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Item shared!'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  icon: const Icon(Icons.share, size: 18),
                  label: const Text('Share Item'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================
  // QUANTITY CONTROL - Icon Buttons
  // ============================================
  Widget _buildQuantityControl() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Quantity',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    if (quantity > 1) quantity--;
                  });
                },
                icon: const Icon(Icons.remove_circle_outline),
                color: Colors.orange,
                iconSize: 30,
              ),
              Container(
                width: 40,
                alignment: Alignment.center,
                child: Text(
                  '$quantity',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    quantity++;
                  });
                },
                icon: const Icon(Icons.add_circle_outline),
                color: Colors.orange,
                iconSize: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================
  // ACTION BUTTONS - Elevated, Outlined, TextButton
  // ============================================
  Widget _buildActionButtons() {
    int totalPrice = (selectedItem?.price ?? 0) * quantity;
    if (addCheese) totalPrice += 20;
    if (extraSauce) totalPrice += 10;

    return Column(
      children: [
        // Elevated Button - Place Order
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              setState(() {
                isOrderPlaced = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Order placed! Total: ₹$totalPrice'),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart_checkout),
            label: Text('Place Order (₹$totalPrice)'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Row with Outlined and Text Buttons
        Row(
          children: [
            // Outlined Button - Save for Later
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Item saved for later!'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                icon: const Icon(Icons.bookmark_border),
                label: const Text('Save Later'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.orange,
                  side: const BorderSide(color: Colors.orange),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Text Button - Clear Selection
            Expanded(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    quantity = 1;
                    addCheese = false;
                    extraSauce = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Selection cleared'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: const Text('Clear Selection'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Icon Button - Close
            CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Close Order'),
                      content: const Text('Are you sure you want to cancel your order?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              quantity = 1;
                              addCheese = false;
                              extraSauce = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Order cancelled'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          child: const Text('Yes'),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.close, color: Colors.red),
                tooltip: 'Close/Cancel Order',
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================
  // TODAY'S SPECIAL
  // ============================================
  Widget _buildTodaySpecial() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.local_offer, color: Colors.orange, size: 20),
                    const SizedBox(width: 8),
                    const Text(
                      "Today's Special",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      showSpecial = !showSpecial;
                    });
                  },
                  icon: Icon(
                    showSpecial ? Icons.expand_less : Icons.expand_more,
                    size: 24,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            if (showSpecial)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Veg Burger',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '₹99',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ============================================
  // ORDER SUCCESS SCREEN
  // ============================================
  Widget _buildOrderSuccessScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 80,
            ),
            const SizedBox(height: 20),
            const Text(
              'Order Placed Successfully!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your order of ${selectedItem?.name} x$quantity',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Total: ₹${(selectedItem?.price ?? 0) * quantity + (addCheese ? 20 : 0) + (extraSauce ? 10 : 0)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 30),
            // Dismiss Button
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  isOrderPlaced = false;
                });
              },
              icon: const Icon(Icons.close),
              label: const Text('Dismiss'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================
// MENU ITEM MODEL
// ============================================
class MenuItem {
  final String name;
  final String description;
  final int price;

  MenuItem(this.name, this.description, this.price);
}