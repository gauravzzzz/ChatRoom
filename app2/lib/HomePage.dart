import 'package:app2/cricket.dart';
import 'package:app2/hockey.dart';
import 'package:app2/tennis.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'football.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  runApp(const Home(user1: '',));
}

class Home extends StatefulWidget {


  final user1;
  const Home({super.key, required this.user1});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selected = 0;
  late final us;
  late final screens;
  void _nItemTapped(int index) {
    setState(() {
      selected = index;
    });
  }

  @override
  void initState() {
    us= widget.user1;
    screens=[
       Football(email: us),
      Cricket(email: us,),
      Tennis(email: us),
      Hockey(email: us),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
        Scaffold(
          body:
          screens[selected],
          backgroundColor: Colors.blue[50],
          bottomNavigationBar:  Container(
            color: Colors.blue.shade700,
            child:Padding (
              padding:const EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Builder(
                builder: (context) {
                  return GNav(
            backgroundColor: Colors.blue.shade700,
           activeColor: Colors.white,
           tabBackgroundColor: Colors.blue.shade600,
                    selectedIndex:selected ,
                    onTabChange:_nItemTapped,
           padding: const EdgeInsets.all(16),
           gap: 8,
           tabs:const [
                  GButton(
                    icon: Icons.sports_football,
                    text: "football",
                  ),
             GButton(
                   icon: Icons.sports_cricket,
                   text: "cricket",
             ),

            GButton(
                    icon: Icons.sports_tennis,
                    text: "tennis",
                  ),
             GButton(
                    icon: Icons.sports_hockey,
                   text: "hockey",
                  ),
            ],
          );
                }
              ),),

        ),

    )
        );
  }
}