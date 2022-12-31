import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled1/signuppage.dart';
import 'First.dart';
import 'Second.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Home());
}
class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final password = TextEditingController();
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/home": (context) => const Home(),
          "/sign": (context) => const Sign(),
          "/first" : (context)=> const First(),
          "/second" : (context)=> const Second(),
        },
        home: Builder(
          builder: (context) {
            return Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  title: const Text("Login"),
                  backgroundColor: Colors.black,
                ),
                body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: TextField(
                            controller: email,
                            minLines: 1,
                            maxLines: 3,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[500],
                              hintStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: 'Email',
                            )),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: TextField(
                            controller: password,
                            minLines: 1,
                            maxLines: 3,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[500],
                              hintStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: 'Password',
                            )),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.red,
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
                              Navigator.of(context).pushNamed("/first");
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                print('No user found for that email.');
                              } else if (e.code == 'wrong-password') {
                                print('Wrong password provided for that user.');
                              }
                            }
                          },
                          child: const Text("Sign in")),
                      signUpOption()
                    ]));
          }
        ));
  }
}
Builder signUpOption() => Builder(
  builder: (context) {
    return     Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Don't have account?",
              style: TextStyle(color: Colors.white70)),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Sign()));
            },
            child: const Text(
              " Sign Up",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      );
  }
);