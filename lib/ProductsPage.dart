import 'package:flutter/material.dart';
import 'CartScreen.dart'; // Import CartScreen

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final List<Map<String, dynamic>> _products = List.generate(
    15,
    (index) => {
      'title': 'Product ${index + 1}',
      'price': 1000.00 + index * 100,
      'imageUrl': 'assets/images/product${index + 1}.jpeg', // Update image path
    },
  );

  List<Map<String, dynamic>> _cart = [];

  void _addToCart(Map<String, dynamic> product) {
    setState(() {
      _cart.add(product);
    });

    // Navigate to CartScreen after adding the product
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(
          cart: _cart,
          onRemoveFromCart: _removeFromCart,
        ),
      ),
    ).then((updatedCart) {
      if (updatedCart != null) {
        setState(() {
          _cart = List<Map<String, dynamic>>.from(updatedCart);
        });
      }
    });
  }

  void _removeFromCart(int index) {
    setState(() {
      _cart.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to CartScreen when cart icon is clicked
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(
                    cart: _cart,
                    onRemoveFromCart: _removeFromCart,
                  ),
                ),
              ).then((updatedCart) {
                if (updatedCart != null) {
                  setState(() {
                    _cart = List<Map<String, dynamic>>.from(updatedCart);
                  });
                }
              });
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return ProductItem(
            title: product['title'],
            price: product['price'],
            imageUrl: product['imageUrl'],
            onAddToCart: () => _addToCart(product),
          );
        },
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final String title;
  final double price;
  final String imageUrl;
  final VoidCallback onAddToCart;

  const ProductItem({
    Key? key,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imageUrl,
            height: 120.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('₨${price.toStringAsFixed(2)}'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: onAddToCart,
              child: const Text('Add to Cart'),
            ),
          ),
        ],
      ),
    );
  }
}
