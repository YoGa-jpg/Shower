import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shower/movie.dart';
import 'search.dart';

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
          color: Colors.black,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ImageButton(
                    radius: 14.0,
                    size: 300,
                    asset: "assets/images/series.jpg",
                    title: "СЕРИАЛЫ",
                    func: () {}),
                ImageButton(
                    radius: 14.0,
                    size: 300,
                    asset: "assets/images/movies.jpg",
                    title: "ФИЛЬМЫ",
                    func: () {})
              ],
            )),
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text("Shower", style: TextStyle(fontFamily: 'Helvetica'),),
          actions: [
            IconButton(icon: Icon(Icons.account_circle_sharp), onPressed: (){},)
          ],
          ),
        ),
      );
  }
}

class ImageButton extends StatelessWidget {
  final double radius;
  final double size;
  final String asset;
  final String title;
  final Function func;

  const ImageButton(
      {Key? key,
      required this.radius,
      required this.size,
      required this.asset,
        required this.title,
      required this.func})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Stack(
            children: [
              Image.asset(asset),
              Container(padding: EdgeInsets.only(top: 5, right: 2.5), alignment: Alignment.topRight, child: Opacity(opacity: 0.5 ,child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    background: Paint()
                      ..strokeWidth = 17.0
                      ..color = Colors.white
                      ..style = PaintingStyle.stroke
                      ..strokeJoin = StrokeJoin.round),
              )))
            ],
          )),
      iconSize: size,
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SearchPage();
        }));
      },
    );
  }
}
