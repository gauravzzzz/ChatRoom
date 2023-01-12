import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  runApp(const Login());
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final password = TextEditingController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home:
    Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.blue[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/image.png')),
              ),
            ),
             Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(keyboardType: TextInputType.emailAddress,
                controller: email,
                decoration: const InputDecoration(

                    labelText: 'Email',
                    hintText: 'Enter the registered email id'),
              ),
            ),
           Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                  controller: password,
                obscureText: true,
                decoration: const InputDecoration(

                    labelText: 'Password',
                    hintText: 'Enter secure password',


                ),
              ),
            ),
            const SizedBox(
              height:30,
            ),
            Container(

              height: 50,
              width: 150,
              decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],

                elevation: 10,
                fixedSize: const Size(150, 40),
              ),
                onPressed: () async {
                  String a = email.text;
                  String b = password.text;
                  try {
                    final credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                      email: a,
                      password: b,
                    );

                    if(!mounted) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Home(
                          user1: a,
                        ),
                      ),
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                    }
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 200,
            ),
            GestureDetector(
              onTap: (){Navigator.pushNamed(context, "/sign");},
                child: const Text('New User? Create Account'))
          ],
        ),
      ),
    ));
  }
}