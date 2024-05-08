import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xizmatdamiz/frontend/screens/home/home.dart';
import 'package:xizmatdamiz/frontend/style/color.dart';

class LoginPage extends StatefulWidget {
  final String email;

  const LoginPage({super.key, required this.email});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
  setState(() {
    _isLoading = true;
  });

  try {
    final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: widget.email,
      password: _passwordController.text,
    );

    Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => const HomePage()),
).then((_) => Navigator.pop(context));
    } catch (e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to login: $e'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Enter Password',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Please enter the password you created during sign up',
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                  const SizedBox(height: 40),
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
              const SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(RGBcolor().mainColor),
                  ),
                  onPressed: _isLoading ? null : _login,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 3.0,
                          ),
                        )
                      : const Icon(
                          CupertinoIcons.mail,
                          color: Colors.white,
                        ),
                  label: Text(
                    _isLoading ? 'Logging in...' : 'Login',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
