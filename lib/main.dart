import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(const AppRoutes());
}

class AppRoutes extends StatelessWidget {
  const AppRoutes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/search': (context) => const SearchPage()
      },
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ImageButton(
                    radius: 14.0,
                    size: 300,
                    asset: "assets/images/marci.jpg",
                    func: () {}),
                ImageButton(
                    radius: 14.0,
                    size: 300,
                    asset: "assets/images/marci.jpg",
                    func: () {})
              ],
            )),
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: const Text("Bar"),
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          scrollDirection: Axis.vertical,
            children: const [
          MovieCard(),
          MovieCard(),
          MovieCard()
        ]),
        appBar: AppBar(title: const Text("Список")),
      ),
    );
  }
}

class ImageButton extends StatelessWidget {
  final double radius;
  final int size;
  final String asset;
  final Function func;

  const ImageButton(
      {Key? key,
      required this.radius,
      required this.size,
      required this.asset,
      required this.func})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: ClipRRect(
          borderRadius: BorderRadius.circular(14.0),
          child: Image.asset("assets/images/marci.jpg")),
      iconSize: 300,
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const SearchPage();
        }));
      },
    );
  }
}

class MovieCard extends StatelessWidget{
  const MovieCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
          color: Colors.lightGreen,
          width: 200,
          height: 300,
        )
    );
  }
}
