import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xizmatdamiz/frontend/screens/profile/accsettings.dart';
import 'package:xizmatdamiz/frontend/screens/verification/emailverify.dart';

import 'package:xizmatdamiz/frontend/style/color.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(user?.uid);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FutureBuilder<DocumentSnapshot>(
              future: userRef.get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Text('User not found');
                }

                final userData = snapshot.data?.data() as Map<String, dynamic>?;
                final userName = userData?['name'] as String?;

                return Column(
                  children: [
                    Icon(
                      CupertinoIcons.person_alt_circle,
                      color: RGBcolor().mainColor,
                      size: 80,
                    ),
                    Text(
                      userName!,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                );
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListTile(
                        leading: Icon(
                          CupertinoIcons.person_alt_circle,
                          color: RGBcolor().mainColor,
                        ),
                        title: const Text('Account Settings'),
                        trailing: const Icon(CupertinoIcons.forward),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const AccSettings()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 100, left: 15),
              child: InkWell(
                onTap: () async {
                  try {
                    await FirebaseAuth.instance.signOut();

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const EmailVerifyPage()),
                    );
                  } catch (e) {}
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      CupertinoIcons.square_arrow_left,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Log Out',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
