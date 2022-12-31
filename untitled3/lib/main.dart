import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  import 'package:http/http.dart'as http;
  import 'package:flutter/material.dart';
  import 'package:firebase_core/firebase_core.dart';
  import 'dart:io';
  import 'dart:convert';
  Future main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    runApp(const First());
  }

  class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _FirstState();
  }


  Map string={};
  List name=[];
  List photos =[];
  class _FirstState extends State<First> {
  Future apic() async {
  http.Response response;
  response = await http.get(Uri.parse(
  "https://api.themoviedb.org/3/movie/popular?api_key=1b5e008bb1cacf05e3cefdc09b434163&language=en-US&page=1"));
  if(response.statusCode == 200){
  setState((){
  string = json.decode(response.body);
  name = string['results'];
  photos = string['results'];
  });
  }
  }
  @override
  void initState(){
  apic();
  super.initState();
  }
  Future<bool> _onWillPop() async {
  return (await showDialog(
  context: context,
  builder: (context) => AlertDialog(
  title: const Text('Are you sure?'),
  content: const Text('Do you want to exit an App'),
  actions: <Widget>[
  TextButton(
  onPressed: () => Navigator.of(context).pop(false), //<-- SEE HERE
  child: const Text('No'),
  ),
  TextButton(
  onPressed: () => exit(0), // <-- SEE HERE
  child: const Text('Yes'),
  ),
  ],
  ),
  )) ??
  false;
  }
  @override
  Widget build(BuildContext context) {
  return WillPopScope(

  onWillPop: _onWillPop,
  child: Scaffold(
  backgroundColor: Colors.black87,
  appBar: AppBar(
  backgroundColor: Colors.black,
  title: Container(
  width: double.infinity,
  height: 50,
  child: TextField(
  style: const TextStyle(
  color: Colors.black,
  ),
  decoration: InputDecoration(
  prefixIcon: const Icon(
  Icons.menu,
  color: Colors.white,
  ),
  filled: true,
  fillColor: Colors.grey[700],
  suffixIcon: const Icon(
  Icons.search,
  size: 30,
  color: Colors.black,
  ),
  hintStyle: const TextStyle(
  color: Colors.white,
  fontSize: 16,
  height: 3.2,
  ),
  border: OutlineInputBorder(
  borderSide: BorderSide.none,
  borderRadius: BorderRadius.circular(10)),
  hintText: "What's New",
  )),
  ),
  ),
  body: Column(

  crossAxisAlignment: CrossAxisAlignment.stretch,
  mainAxisSize: MainAxisSize.min,
  children: <Widget>[
  Container(

  padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
  child: const Text(
  "Trending Movies",
  textAlign: TextAlign.left,
  style: TextStyle(color: Colors.grey, fontSize: 18),
  ),
  ),
  Flexible(
  flex: 1,
  child: SizedBox(

  height: 150,
  width: double.infinity,
  child: ListView.builder(
  shrinkWrap: true,
  scrollDirection: Axis.horizontal,
  itemCount: name.length,
  itemBuilder: (BuildContext context, int index) =>
  Card(
  elevation: 10,
  color: Colors.grey,
  shape: const RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(7))),
  child: Center(child:Text(name[index]['original_title'].toString())),
  ),
  ),
  ),
  ),
  Container(
  padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
  child: const Text(
  "New Movies",
  textAlign: TextAlign.left,
  style: TextStyle(color: Colors.grey, fontSize: 18),
  ),
  ),
  Flexible(
  flex: 1,
  child: SizedBox(
  height: 150,
  width: double.infinity,
  child: ListView.builder(
  shrinkWrap: true,
  scrollDirection: Axis.horizontal,
  itemCount: 15,
  itemBuilder: (BuildContext context, int index) =>
  const Card(
  elevation: 10,
  color: Colors.grey,
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(7))),
  child: Center(child: Text('Dummy Card Text')),
  ),
  ),
  ),
  ),
  Container(
  padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
  child: const Text(
  "Now Playing",
  textAlign: TextAlign.left,
  style: TextStyle(color: Colors.grey, fontSize: 18),
  ),
  ),

  Flexible(
  flex: 1,
  child: SizedBox(
  height: 150,
  width: double.infinity,
  child: ListView.builder(
  shrinkWrap: true,
  scrollDirection: Axis.horizontal,
  itemCount: 15,
  itemBuilder: (BuildContext context, int index) =>
  const Card(
  elevation: 10,
  color: Colors.grey,
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(7))),
  child: Center(child: Text('Dummy Card Text')),
  ),
  ),
  ),
  ),
  ])));
  }
  }

