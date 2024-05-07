import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xizmatdamiz/frontend/style/color.dart';
import 'package:flutter/cupertino.dart';

class OrderStart extends StatelessWidget {
  final DocumentSnapshot item;

  const OrderStart({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('orders').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final documents = snapshot.data!.docs;
        
        // Check if there are no documents
        if (documents.isEmpty) {
          return const Text('No orders found');
        }

        // If there are documents, display order details
        final doc = documents.first;
        final cosname = doc['cosname'] as String?;
        final type = doc['type'] as bool?;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  CupertinoIcons.person,
                  color: RGBcolor().mainColor,
                ),
                const SizedBox(width: 4.0),
                Text(cosname ?? ''),
              ],
            ),
            Row(
              children: [
                Icon(
                  CupertinoIcons.square_arrow_down,
                  color: RGBcolor().mainColor,
                ),
                const SizedBox(width: 4.0),
                Text(type! ? "Single Trip" : "Round Trip"),
              ],
            ),
          ],
        );
      },
    );
  }
}
