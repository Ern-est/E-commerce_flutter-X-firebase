import 'package:flutter/material.dart';
import 'package:mara_pub/pages/payment_screen.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';
import '../models/drink.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);
    final cartItems = cart.cartItems;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'My Cart',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child:
                cartItems.isEmpty
                    ? const Center(
                      child: Text(
                        'Your cart is empty 😢',
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                    : ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final drink = cartItems[index];
                        return ListTile(
                          leading: Image.asset(
                            drink.imagePath,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            drink.name,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            '\$${drink.price.toStringAsFixed(2)}',
                            style: const TextStyle(color: Colors.amberAccent),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            onPressed: () {
                              cart.removeFromCart(drink);
                            },
                          ),
                        );
                      },
                    ),
          ),
          if (cartItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        '\$${cart.getTotalPrice().toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.amberAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    margin: EdgeInsets.all(8),
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder:
                              (_) => AlertDialog(
                                backgroundColor: Colors.grey[900],
                                title: const Text(
                                  'Confirm Order',
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: const Text(
                                  'Are you sure you want to proceed to payment?',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.redAccent),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  TextButton(
                                    child: const Text(
                                      'Proceed',
                                      style: TextStyle(
                                        color: Colors.greenAccent,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(
                                        context,
                                      ); // close the dialog
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const PaymentScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: const Color.fromARGB(
                          255,
                          251,
                          64,
                          185,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.purpleAccent, Colors.pinkAccent],
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(12),
                          alignment: Alignment.center,
                          child: Text(
                            'C H E C K O U T',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
