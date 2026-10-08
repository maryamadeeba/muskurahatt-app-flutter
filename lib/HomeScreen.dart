import 'package:flutter/material.dart';
import 'ProductsPage.dart'; 
import 'AboutUsPage.dart';// Import the Products Page
import 'AccountPage.dart';

void main() => runApp(const GiftShopApp());

class GiftShopApp extends StatelessWidget {
  const GiftShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Roboto',
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Tracks the currently selected bottom navigation tab.

  // Screens for bottom navigation.
  final List<Widget> _pages = [
    const HomeScreenContent(),
    const ProductsPage(),
    const AboutUsScreen(),
    const AccountPage(), // Placeholder for Account Page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Muskurahatt.co',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'CustomFont',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen(cart: const [], cartItems: const [], onClearCart: () {  },)),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.pink,
              ),
              child: Text(
                'Main Menu',
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                setState(() {
                  _currentIndex = 0; // Navigate to Home.
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Products'),
              onTap: () {
                setState(() {
                  _currentIndex = 1; // Navigate to Products.
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Cart'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen(cart: const [], cartItems: const [], onClearCart: () {  },)),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About Us'),
              onTap: () {
                setState(() {
                  _currentIndex = 2; // Navigate to About us.
                });
                Navigator.pop(context);
              },
            ),
             ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Account'),
              onTap: () {
                setState(() {
                  _currentIndex = 3; // Navigate to Account.
                });
                Navigator.pop(context);
              },
            ),

          ],
        ),
      ),
      body: _pages[_currentIndex], // Show the selected page.
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.pink[200],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Products'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About Us'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for gifts...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          // Slider Section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SizedBox(
              height: 150.0,
              child: PageView(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://static.vecteezy.com/system/resources/previews/013/536/539/non_2x/11-11-shopping-day-sale-global-shopping-world-day-sale-on-colorful-background-vector.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Categories Section
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Categories',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CategoryItem(
                  title: 'Gift Baskets',
                  imageUrl:
                      'https://www.lalschocolates.com/cdn/shop/files/gourmetbasket-01.jpg?v=1693997949',
                ),
                CategoryItem(
                  title: 'Flowers',
                  imageUrl:
                      'https://sendflowers.pk/wp-content/uploads/2023/04/WhatsApp-Image-2023-04-05-at-4.36.36-PM.jpeg',
                ),
                CategoryItem(
                  title: 'Teddy Bears',
                  imageUrl:
                      'https://www.theentertainer.pk/cdn/shop/files/559002SnuggleBuddies70cmTeddyBear-Charlie1.jpg?v=1684827610',
                ),
                CategoryItem(
                  title: 'Jewelry',
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8MDaOfZGNXGcpPrydIYqHrGLVVeSiKHqf9w&s',
                ),
                CategoryItem(
                  title: 'Gift Cards',
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUHuzFcZOXgfosuofpvGSJBGqhFQIiRF21BA&s',
                ),
              ],
            ),
          ),
          // Featured Products Section
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Featured Products',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 200.0,
            child: Center(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  ProductItem(
                    title: 'Teddy Bear',
                    price: 1500.00,
                    imageUrl:
                        'https://assets.flowerstore.ph/public/tenantPH/app/assets/images/variant/600_LE015iX028BZ3avs8UcQ9Kl1Q.webp',
                  ),
                  ProductItem(
                    title: 'Rose Bouquet',
                    price: 2500.00,
                    imageUrl:
                        'https://api.floraindia.com/upload/L7tNvl7r7U1725270635459.webp',
                  ),
                  ProductItem(
                    title: 'Gift Basket',
                    price: 6000.00,
                    imageUrl:
                        'https://sentimentsexpress.com/cdn/shop/products/NecosCombos7_600x.jpg?v=1649309996',
                  ),
                ],
              ),
            ),
          ),
          // Special Offer Section
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Special Offer',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.pink[50],
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.pink, width: 1.0),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Limited Time Offer!',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4.0),
                    Text('Get 30% off on all Gift Baskets!'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  const CategoryItem({super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              imageUrl,
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            title,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final String title;
  final double price;
  final String imageUrl;

  const ProductItem(
      {super.key, required this.title, required this.price, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              imageUrl,
              width: 120.0,
              height: 120.0,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            title,
            textAlign: TextAlign.center,
          ),
          Text(
            'PKR $price',
            style: const TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required List<Map<String, dynamic>> cart, required List cartItems, required Null Function() onClearCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: const Center(
        child: Text(
          'Your cart is empty!',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}