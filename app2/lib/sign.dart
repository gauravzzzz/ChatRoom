import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'package:flutter/foundation.dart';
import 'login.dart';
import 'otp.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const sign());
}

class sign extends StatefulWidget {
  const sign({super.key});

  @override
  State<sign> createState() => _signState();
}

class _signState extends State<sign> {
  @override
  Widget build(BuildContext context) {
    final phone = TextEditingController();
    String verify = "";
    final FirebaseAuth auth = FirebaseAuth.instance;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.blue[50],
          appBar: AppBar(
            title: const Text("Sign-up"),
            backgroundColor: Colors.blue[700],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Center(
                    child: Container(
                        width: 200,
                        height: 150,
                        child: Image.asset('assets/image.png')),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: phone,
                    decoration: const InputDecoration(
                        helperText: 'An otp will be sent to this number',
                        labelText: 'Phone number',
                        hintText: 'Enter valid phone number '),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 50,
                  width: 200,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      elevation: 10,
                    ),
                    onPressed: () async {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '+91 ${phone.text}',
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          verify = verificationId;
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                      if(!mounted)return;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Otp(
                            verify1: verify,
                          ),),);
                    },
                    child: const Text(
                      'Get Started',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
