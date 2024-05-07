import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xizmatdamiz/frontend/style/color.dart';

class HistoryTile extends StatelessWidget {
  final DocumentSnapshot item;

  const HistoryTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pick Up from:',
          style: TextStyle(color: RGBcolor().mainColor),
        ),
        Text(
          item['oaddress'],
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        const Icon(CupertinoIcons.arrow_down),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Delivery to',
          style: TextStyle(color: RGBcolor().mainColor),
        ),
        Text(
          item['raddress'],
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider(),
        const SizedBox(
          height: 20,
        ),
        Text(item['thing']),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
