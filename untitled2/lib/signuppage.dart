
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_auth/email_auth.dart';
import 'package:pinput/pinput.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
  home : Sign())
  );
}
class Sign extends StatefulWidget{
  const Sign({super.key});
  @override
  State<Sign> createState() => _Sign();
}

class _Sign extends State<Sign> {
  late EmailAuth emailAuth;
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final email = TextEditingController();
    final password = TextEditingController();
    final phone = TextEditingController();
    final otp =TextEditingController();
     String verify = "";
    bool the = false;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios),),
              title: const Text("Signup"),
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
                          hintText: 'New Password',
                        )),
                  ),

                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: TextField(
                        controller:phone,
                        minLines: 1,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          suffixIcon: TextButton(

                            onPressed: () async { await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: '+91 ${phone.text}',
                              verificationCompleted:
                                  (PhoneAuthCredential credential) {},
                              verificationFailed: (FirebaseAuthException e) {},
                              codeSent:
                                  (String verificationId, int? resendToken) {
                               verify = verificationId;
                                  },
                              codeAutoRetrievalTimeout: (String verificationId) {},
                            );}, child: const Text("OTP",
                          style: TextStyle(
                            color: Colors.black,
                          )),

                          ),
                          filled: true,
                          fillColor: Colors.grey[500],
                          hintStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10)),
                          hintText: 'Phone Number',
                        )),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child:
                    Pinput(
                      length: 6,
                      controller: otp,
                      showCursor: true,
                      onCompleted: (pin) => print(pin),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        elevation: 10,
                        fixedSize: const Size(150, 40),
                      ),
                      onPressed: () async{
                        String a = email.text;
                        String b = password.text;
                        try{
                          PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verify, smsCode: otp.text);
                          // Sign the user in (or link) with the credential
                          await auth.signInWithCredential(credential);
                         the= true;

                        }catch(e){
                          if (kDebugMode) {
                            print("wrong otp");
                          }
                        }
                        try {
                          final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(

                            email: a,
                            password: b,
                          );
                          if(!mounted)return;
                          if(the){
                          Navigator.of(context).pop();}
                        }
                        on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            if (kDebugMode) {
                              print('The password provided is too weak.');
                            }
                          } else if (e.code == 'email-already-in-use') {
                            if (kDebugMode) {
                              print('The account already exists for that email.');
                            }
                          }
                        } catch (e) {
                          if (kDebugMode) {
                            print(e);
                          }
                        } },
                      child: const Text("Sign-up")),

                ])));
  }
}


