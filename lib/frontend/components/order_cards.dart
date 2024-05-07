import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xizmatdamiz/frontend/utils/order_start.dart';
import 'package:xizmatdamiz/frontend/utils/order_tile.dart';

class OrderCard extends StatelessWidget {
  final DocumentSnapshot item;
  const OrderCard({
    required this.item,
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: PhysicalModel(
        color: Colors.transparent,
        elevation: 8,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: ExpansionTile(
          trailing: const SizedBox.shrink(),
          collapsedShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          collapsedBackgroundColor: Colors.white,
          backgroundColor: Colors.white,
          expandedAlignment: Alignment.centerLeft,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          tilePadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
          title: OrderStart(item: item),
          childrenPadding: const EdgeInsets.only(left: 18.0),
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: OrderTile(item: item),
            ),
          ],
        ),
      ),
    );
  }
}
