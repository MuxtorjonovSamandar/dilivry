import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xizmatdamiz/frontend/style/color.dart';

class HistoryStart extends StatelessWidget {
  final DocumentSnapshot item;

  const HistoryStart({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    bool status = false;
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('acceptedOrders').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final documents = snapshot.data!.docs;

        return Wrap(
          runSpacing: 4,
          children: documents.map((doc) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.profile_circled,
                      color: RGBcolor().mainColor,
                    ),
                    const SizedBox(width: 4.0),
                    Text(doc['cosname']),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.bag_fill,
                      color: RGBcolor().mainColor,
                    ),
                    const SizedBox(width: 4.0),
                    Text(status ? 'Done' : 'Delivering'),
                  ],
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
