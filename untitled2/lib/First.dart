import 'Second.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'dart:convert';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MaterialApp(
      home: First()));
}

class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _FirstState();
}
Map string={};
Map string1 = {};
Map string2 = {};
List<dynamic> photos=[];
List<dynamic> photos1 =[];
List <dynamic> photos2 =[];
List <dynamic> photosd=[];
List <dynamic> photos1d=photos1;
List <dynamic> photos2d =photos2;
class _FirstState extends State<First> {
  Future apic() async {
    http.Response response;
    response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=1b5e008bb1cacf05e3cefdc09b434163&language=en-US&page=1"));
    if(response.statusCode == 200){
      setState((){
        string = json.decode(response.body);
        photos = string['results'] ?? ['1'];
        photosd = string['results'] ?? ['1'];
      });
    }
  }
  Future apicc() async {
    http.Response response1;
    response1 = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/top_rated?api_key=1b5e008bb1cacf05e3cefdc09b434163&language=en-US&page="));
    if(response1.statusCode == 200){
      setState((){
        string1= json.decode(response1.body);
        photos1 = string1['results'] ?? ['1'];
        photos1d = string1['results'] ?? ['1'];
      });
    }
  }
  Future apiccc() async {
    http.Response response2;
    response2 = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/now_playing?api_key=1b5e008bb1cacf05e3cefdc09b434163&language=en-US&page=1"));
    if(response2.statusCode == 200){
      setState((){
        string2 = json.decode(response2.body);
        photos2 = string2['results'] ?? ['1'];
        photos2d = string2['results'] ?? ['1'];
      });
    }
  }
@override
void initState(){
    apic();apicc();apiccc();
    super.initState();
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(

            backgroundColor: Colors.black87,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Container(
                width: double.infinity,
                height: 50,
                child: TextField(
                  onChanged: (text){
                    text = text.toLowerCase();
                   setState(() {
                     photosd = photos.where((u) {
                       var first = u['title'].toString();
                       first=first.toLowerCase();
                       return first.contains(text);
                     }).toList();
                   });
                    setState(() {
                      photos1d = photos1.where((u) {
                        var first = u['title'].toString();
                        first=first.toLowerCase();
                        return first.contains(text);
                      }).toList();
                    });
                    setState(() {
                      photos2d = photos2.where((u) {
                        var first = u['title'].toString();
                        first=first.toLowerCase();
                        return first.contains(text);
                      }).toList();
                    });
                  },
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
                    padding: const EdgeInsets.fromLTRB(10,4,0, 4),
                    child: const Text(
                      "Trending Movies",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ),
                    Flexible(
                      flex: 1,
                    child: SizedBox(
                      height: 180,
                      width: double.infinity,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: photosd.length ,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Second(
                                   integer: index,
                                  ),),);
                            },
                            child: Card(
                              elevation: 10,
                              color: Colors.grey,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      10))),
                                  child:Image.network(
                                "http://image.tmdb.org/t/p/w500/${photosd[index]['poster_path']
                                    .toString()}",
                              ),
                            ),
                          );
                        }
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                    child: const Text(
                      "Top Rated",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      height: 180,
                      width: double.infinity,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount:  photos1d.length,
                        itemBuilder: (BuildContext context, int index) =>
                           Card(
                          elevation: 10,
                          color: Colors.grey,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(7))),
                          child: Image.network(
                            "http://image.tmdb.org/t/p/w500/${photos1d[index]['poster_path']
                                .toString()}",
                          ),
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
                      height: 180,
                      width: double.infinity,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: photos2d.length,
                        itemBuilder: (BuildContext context, int index) =>
                             MouseRegion(
                               onHover: (event) {

                               },
                               // When it exits set it back to default
                               onExit: (event) {

                               },
                               child: InkWell(
                                 onTap: (){

                               },
                                 child: Card(
                          elevation: 10,
                          color: Colors.grey,
                          shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(7))),
                          child:Image.network(
                            "http://image.tmdb.org/t/p/w500/${photos2d[index]['poster_path']
                                    .toString()}",
                          ),
                        ),
                               ),
                             ),
                      ),
                    ),
                  ),
                ])));
  }
}
