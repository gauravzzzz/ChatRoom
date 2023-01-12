import 'package:app2/cricket.dart';
import 'package:app2/otp.dart';
import 'package:app2/sign.dart';
import 'package:app2/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'HomePage.dart';
import 'login.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
        routes: {
          "/Login": (context) => const Login(),
          "/sign": (context) => const sign(),
          "/signup": (context) => const Signup(),

        },
      home: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.blue[50],
           body: Column(
             children: [
               Center(
                 child: Container(

                        padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),

                   child: Image.asset('assets/image.png', height: 300,),
                 ),
               ),
               const SizedBox(
                 height: 120,
               ),
              Expanded(
                child: Container(

                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  height: 100,

   child: Row(
    children : <Widget>[

    Container(
    child:ElevatedButton(

    onPressed: () {  Navigator.of(context).pushNamed("/Login");},
    child: const Text("Login")
    )
    ),
    Container(
          padding: EdgeInsets.fromLTRB(230, 0, 0, 0),
   child: ElevatedButton(
    onPressed: () { Navigator.of(context).pushNamed("/sign"); },
    child: Text("Sign-up")
    ),
    ),
    ]),
                ),
              ),

             ],
           ),
          );
        }
      ),
    );


  }
}
