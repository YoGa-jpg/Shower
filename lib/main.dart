import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Container(
            alignment: Alignment.center,
              child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
            IconButton(
            icon: ClipRRect(borderRadius: BorderRadius.circular(20.0),child:Image.asset("assets/images/marci.jpg")),
            iconSize: 300,
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset("assets/images/marci.jpg"),
            iconSize: 300,
            onPressed: () {},
          )
        ],
      )),
      appBar: AppBar(
        backgroundColor: Colors.redAccent
      ),),
    );
  }
}
