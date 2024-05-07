import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xizmatdamiz/frontend/screens/verification/log_in.dart';
import 'package:xizmatdamiz/frontend/screens/verification/sign_up.dart';
import 'package:xizmatdamiz/frontend/style/color.dart';

class VerifyPage extends StatefulWidget {
  final String email;
  final String verificationCode;

  VerifyPage({
    Key? key,
    required this.email,
    required this.verificationCode,
  }) : super(key: key);

  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final TextEditingController _codeController = TextEditingController();
  String _errorText = '';
  bool _isLoading = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _verifyCode() async {
    setState(() {
      _errorText = '';
      _isLoading = true;
    });

    try {
      String enteredCode = _codeController.text.trim();

      // Check if the email exists in the Firebase database
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: widget.email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Email exists, navigate to the login page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(email: widget.email),
          ),
        );
      } else {
        // Email doesn't exist, navigate to the sign-up page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignupPage(email: widget.email),
          ),
        );
      }
    } catch (e) {
      // Handle specific exception when no documents are returned
      if (e is FirebaseException && e.code == 'permission-denied') {
        // Email doesn't exist, navigate to the sign-up page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignupPage(email: widget.email),
          ),
        );
      } else {
        // Other errors
        setState(() {
          _errorText = 'Error verifying email. Please try again.';
          _isLoading = false;
        });
      }
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
                    'Enter Code: ',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${widget.email} ',
                    style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                  const SizedBox(height: 40.0),
                  TextField(
                    controller: _codeController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Verification Code',
                      errorText: _errorText.isNotEmpty ? _errorText : null,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(RGBcolor().mainColor),
                    ),
                    onPressed: _verifyCode,
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
                            CupertinoIcons.square_arrow_down,
                            color: Colors.white,
                          ),
                    label: Text(
                      _isLoading ? 'Checking...' : "Check",
                      style: const TextStyle(color: Colors.white),
                    ),
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
