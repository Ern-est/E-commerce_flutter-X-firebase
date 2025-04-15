import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/drink.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> storeOrder(List<Drink> drinks, double totalPrice) async {
    final user = _auth.currentUser;

    if (user == null) return;

    List<Map<String, dynamic>> drinkData =
        drinks
            .map(
              (drink) => {
                'name': drink.name,
                'price': drink.price,
                'imagePath': drink.imagePath,
              },
            )
            .toList();

    await _firestore.collection('orders').add({
      'userId': user.uid,
      'email': user.email,
      'items': drinkData,
      'totalPrice': totalPrice,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
