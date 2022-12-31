import 'package:flutter/material.dart';

import 'First.dart';

class Second extends StatefulWidget {
  final int integer;
  const Second({super.key, required this.integer});
  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(

            backgroundColor: Colors.black,
            title: Text(photosd[widget.integer]['title'].toString(),
              style: const TextStyle(color: Colors.white),),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                width: double.infinity,
                height: 300,
                child: Image.network(
                  width: double.infinity,
                  height: 300,
                  "http://image.tmdb.org/t/p/w500/${photosd[widget.integer]['poster_path'].toString()}",
                ),
              ),

              Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  photosd[widget.integer]['overview'].toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              )
            ],
          )),
    );
  }
}
