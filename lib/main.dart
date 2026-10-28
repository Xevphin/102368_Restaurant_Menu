import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Data Model to cleanly structure each food entry
class FoodItem {
  final String name;
  final String category;
  final String price;
  final String description;
  final String imagePath;

  const FoodItem({
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.imagePath,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Menu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const MenuHomeScreen(),
    );
  }
}

class MenuHomeScreen extends StatelessWidget {
  const MenuHomeScreen({super.key});

  // Three distinct food categories
  final List<FoodItem> menuItems = const [
    FoodItem(
      name: 'Classic Cheeseburger',
      category: 'Burgers',
      price: '\$8.50',
      description: 'Juicy beef patty grilled to perfection, topped with melted cheddar, crisp lettuce, fresh tomatoes, and our signature house sauce.',
      imagePath: 'assets/images/burger.png',
    ),
    FoodItem(
      name: 'Margherita Pizza',
      category: 'Pizza',
      price: '\$12.00',
      description: 'Stone-baked thin crust topped with rich San Marzano tomato sauce, fresh buffalo mozzarella, aromatic basil leaves, and extra virgin olive oil.',
      imagePath: 'assets/images/pizza.png',
    ),
    FoodItem(
      name: 'Creamy Fettuccine Alfredo',
      category: 'Pasta',
      price: '\$10.50',
      description: 'Tender fettuccine ribbons tossed in a velvety garlic-infused Parmesan cream sauce, garnished with fresh flat-leaf parsley.',
      imagePath: 'assets/images/pasta.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Gourmet Delights Menu',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        elevation: 2,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return Card(
            elevation: 4.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                // Navigate to the detail screen on card tap
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodDetailScreen(food: item),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset(
                        item.imagePath,
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback placeholder if asset is missing during build
                          return Container(
                            width: 90,
                            height: 90,
                            color: Colors.deepOrange.shade100,
                            child: const Icon(
                              Icons.fastfood,
                              color: Colors.deepOrange,
                              size: 40,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.category.toUpperCase(),
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.deepOrange.shade700,
                              letterSpacing: 1.1,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            item.price,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16.0,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FoodDetailScreen extends StatelessWidget {
  final FoodItem food;

  const FoodDetailScreen({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          food.name,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrange,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 250,
              color: Colors.deepOrange.shade50,
              child: Image.asset(
                food.imagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.fastfood,
                    size: 100,
                    color: Colors.deepOrange,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          food.name,
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Text(
                        food.price,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Chip(
                    label: Text(
                      food.category,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.deepOrange,
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'About this dish',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    food.description,
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.black54,
                      height: 1.5,
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
}