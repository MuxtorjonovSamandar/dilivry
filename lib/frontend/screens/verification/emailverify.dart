import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:xizmatdamiz/frontend/screens/verification/verify.dart';
import 'package:xizmatdamiz/frontend/style/color.dart';

class EmailVerifyPage extends StatefulWidget {
  const EmailVerifyPage({super.key});

  @override
  _EmailVerifyPageState createState() => _EmailVerifyPageState();
}

class _EmailVerifyPageState extends State<EmailVerifyPage> {
  final TextEditingController _emailController = TextEditingController();
  String _verificationCode = '';
  bool _isSending = false;

  void _sendVerificationEmail() async {
    setState(() {
      _isSending = true;
    });

    String username = 'gamecenterfor2022@gmail.com';
    String password = 'clttphhtsinexgcm';

    String email = _emailController.text;
    _generateVerificationCode();

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Xizmatdamiz')
      ..recipients.add(email)
      ..subject = 'Xizmatdamiz dasturiga kirish'
      ..text = 'Your verification code is: $_verificationCode';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: $sendReport');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyPage(
            email: email,
            verificationCode: _verificationCode,
          ),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to send verification email: $e'),
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
        _isSending = false;
      });
    }
  }

  void _generateVerificationCode() {
    _verificationCode = (Random().nextInt(900000) + 100000).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Verify Your Email',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12.0),
                  const Text(
                    'A verification code will be sent to the entered email address.',
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                  const SizedBox(height: 40.0),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(RGBcolor().mainColor),
                  ),
                  onPressed: _isSending ? null : _sendVerificationEmail,
                  icon: _isSending
                      ? const SizedBox(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 3.0,
                          ),
                        )
                      : const Icon(
                          CupertinoIcons.mail,
                          color: Colors.white,
                        ),
                  label: Text(
                    _isSending ? 'Sending...' : 'Send Verification Email',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
