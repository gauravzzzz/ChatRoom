
import 'package:flutter/material.dart';
class Second extends StatefulWidget{
  final integer;
  const Second(
      {super.key,  this.integer});
  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
return MaterialApp(
  home: Scaffold(
    appBar: AppBar(
      title: const Text("data"),
    ),
  ),
);
  }
}