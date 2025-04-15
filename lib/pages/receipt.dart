import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart'; // Adjust path if needed
import '../models/drink.dart'; // Adjust path if needed

class Receipt extends StatelessWidget {
  const Receipt({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Order Receipt"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.receipt_long, size: 80, color: Colors.greenAccent),
            const SizedBox(height: 16),
            const Text(
              "Thank You for Your Order!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),

            // RECEIPT BOX
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade700),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade900,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Receipt",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.amberAccent,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // List of items
                  ...cart.cartItems.map((drink) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            drink.name,
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            "\$${drink.price.toStringAsFixed(2)}",
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    );
                  }).toList(),

                  const Divider(color: Colors.white30, height: 30),

                  // Total
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\$${cart.getTotalPrice().toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.amberAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            const Text(
              "Estimated delivery time: 4:10 PM",
              style: TextStyle(color: Colors.white54),
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: () {
                // Clear cart and return to home
                cart.clearCart();
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
