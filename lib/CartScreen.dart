import 'package:flutter/material.dart';
import 'Checkout.dart';

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cart;
  final Function(int index) onRemoveFromCart;

  const CartScreen({
    Key? key,
    required this.cart,
    required this.onRemoveFromCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalPrice = cart.fold(
      0,
      (sum, item) => sum + (item['price'] as double),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.isEmpty
                ? const Center(
                    child: Text('Your cart is empty!'),
                  )
                : ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final product = cart[index];
                      return ListTile(
                        leading: Image.asset(
                          product['imageUrl'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(product['title']),
                        subtitle: Text('₨${product['price'].toStringAsFixed(2)}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle),
                          onPressed: () {
                            onRemoveFromCart(index);
                            // Pop the cart with the updated list back to ProductsPage
                            Navigator.pop(context, cart);
                          },
                        ),
                      );
                    },
                  ),
          ),
          if (cart.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Total: ₨${totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
Padding(
  padding: const EdgeInsets.all(16.0),
  child: ElevatedButton(
    onPressed: () {
      // Navigate to the CheckoutPage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckoutPage(cart: cart), // Passing cart data
        ),
      );
    },
    child: const Text('Proceed to Checkout'),
  ),
),

          ],
        ],
      ),
    );
  }
}
