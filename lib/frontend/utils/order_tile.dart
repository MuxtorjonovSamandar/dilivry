import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:xizmatdamiz/frontend/style/color.dart';

class OrderTile extends StatelessWidget {
  final DocumentSnapshot item;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

 OrderTile({super.key, required this.item});

  Future<void> _handleAcceptOrder(BuildContext context) async {
    try {
      final Map<String, dynamic>? data =
          item.data() as Map<String, dynamic>?;

      if (data != null) {
        await FirebaseFirestore.instance.collection('acceptedOrders').add({
          ...data,
          'status': true,
        });
        await FirebaseFirestore.instance.collection('orders').doc(item.id).delete();
        scaffoldMessengerKey.currentState?.showSnackBar(
          const SnackBar(content: Text('Order accepted successfully')),
        );
      }
    } catch (e) {
      print('Error accepting order: $e');
      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(content: Text('Failed to accept order')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? data =
        item.data() as Map<String, dynamic>?;

    final String oaddress = data?['oaddress'] as String? ?? '';
    final String raddress = data?['raddress'] as String? ?? '';
    final String thing = data?['thing'] as String? ?? '';

    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pick Up from:',
            style: TextStyle(color: RGBcolor().mainColor),
          ),
          Text(
            oaddress,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 12),
          Icon(
            CupertinoIcons.arrow_down,
            color: RGBcolor().mainColor,
          ),
          const SizedBox(height: 12),
          Text(
            'Delivery to:',
            style: TextStyle(color: RGBcolor().mainColor),
          ),
          Text(
            raddress,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          Text(
            thing,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              _handleAcceptOrder(context);
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(RGBcolor().mainColor),
            ),
            child: const Text(
              'Accept',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
