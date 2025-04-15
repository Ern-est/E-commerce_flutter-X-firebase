import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';
import '../models/drink.dart';
import 'payment_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Checkoutt'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Expanded(
              child:
                  cart.cartItems.isEmpty
                      ? const Center(
                        child: Text(
                          'Your cart is empty',
                          style: TextStyle(color: Colors.white54),
                        ),
                      )
                      : ListView.builder(
                        itemCount: cart.cartItems.length,
                        itemBuilder: (context, index) {
                          Drink drink = cart.cartItems[index];
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
                            trailing: Text(
                              '\$${drink.price.toStringAsFixed(2)}',
                              style: const TextStyle(color: Colors.amberAccent),
                            ),
                          );
                        },
                      ),
            ),
            const Divider(color: Colors.white24),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${cart.getTotalPrice().toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.amberAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    child: ElevatedButton(
                      onPressed:
                          cart.cartItems.isEmpty
                              ? null
                              : () {
                                showDialog(
                                  context: context,
                                  builder:
                                      (_) => AlertDialog(
                                        title: const Text(
                                          "Proceed to Payment?",
                                        ),
                                        content: const Text(
                                          "You're about to pay for your drinks.",
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed:
                                                () =>
                                                    Navigator.of(context).pop(),
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (_) =>
                                                          const PaymentScreen(),
                                                ),
                                              );
                                            },
                                            child: const Text("Yes"),
                                          ),
                                        ],
                                      ),
                                );
                              },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
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
                      child: const Text("Checkoutt"),
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
