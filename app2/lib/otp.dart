import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'sign.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  runApp(
      Otp( verify1: ''));
}

class Otp extends StatefulWidget {
   String verify1;
   Otp({super.key, required this.verify1});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  @override
  Widget build(BuildContext context) {
    String otp1="";
    final FirebaseAuth auth = FirebaseAuth.instance;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;  bool the = false;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.07,
              ),
              Text(
                'Verification Code',
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 32.0,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                      'Please enter the verification code that we have sent to your Mobile Number',
                      style: GoogleFonts.urbanist(
                        fontSize: 14.0,
                        color: const Color(0xff808d9e),
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: width,
                  child: Pinput(
                    errorText: 'Error',

                    length: 6,

                    showCursor: true,
                    onCompleted: (pin) { setState((){
                      otp1=pin;
                    });
                    print(otp1);
                    print(widget.verify1);},

                  ),
                ),
              ),

              const SizedBox(
                height: 16.0,
              ),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Resend Button',
                    style: GoogleFonts.urbanist(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),


              const Expanded(child: SizedBox()),
              InkWell(
                onTap: () {
      Navigator.pushNamed(context, "/signup");
                },
                borderRadius: BorderRadius.circular(30.0),
                child: Ink(
                  height: 55.0,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Text(
                      'Continue',
                      style: GoogleFonts.urbanist(
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}