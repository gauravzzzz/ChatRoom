import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'messagef.dart';

class Football extends StatefulWidget {
  String email;
  Football({super.key, required this.email});
  @override
  State<Football> createState() => _FootballState();
}

class _FootballState extends State<Football> {

  final fs = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Football',
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              _auth.signOut().whenComplete(() {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              });
            },
            child: Text(
              "signOut",
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.67,
              child: messagesf(
                email: widget.email,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: message,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.purple[100],
                      hintText: 'message',
                      enabled: true,
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide:  BorderSide(color: Colors.purple),
                        borderRadius:  BorderRadius.circular(10),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:  const BorderSide(color: Colors.purple),
                        borderRadius:  BorderRadius.circular(10),
                      ),
                    ),

                    onChanged: (value) {
                      message.text = value!;
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (message.text.isNotEmpty) {
                      fs.collection('messagesf').doc().set({
                        'message': message.text.trim(),
                        'time': DateTime.now(),
                        'email': widget.email,
                      });

                      message.clear();
                    }
                  },
                  icon: const Icon(Icons.send_sharp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}