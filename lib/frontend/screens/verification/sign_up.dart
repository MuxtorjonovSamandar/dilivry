import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xizmatdamiz/frontend/screens/home/home.dart';
import 'package:xizmatdamiz/frontend/style/color.dart';

class SignupPage extends StatefulWidget {
  final String email;

  const SignupPage({super.key, required this.email});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: widget.email,
        password: _passwordController.text,
      );

      String userId = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'name': _nameController.text,
        'surname': _surnameController.text,
        'email': widget.email,
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      print('Sign-up error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Verification successful. Create your sign up password',
                  style: TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: _surnameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Surname',
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: TextEditingController(text: widget.email),
                      readOnly: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60.0),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _signUp,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(RGBcolor().mainColor),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(color: Colors.white)),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 16.0)),
                      ),
                      child: Text(
                        _isLoading ? 'Signing Up...' : 'Sign Up',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
