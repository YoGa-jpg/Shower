import 'package:flutter/cupertino.dart';
import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MoviePage extends StatelessWidget{
  var _url = 'https://datalock.ru/player/27180';

  MoviePage({Key? key}) : super(key: key);

  void _launchURL() async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.green,
      home: Scaffold(
        body: Column(children: [
          Description(),
          RaisedButton(
            onPressed: _launchURL,
            child: Text('Show Flutter homepage'),
          ),
        ],),
        appBar: AppBar(title: Text('Мандалорец')),
      ),
    );
  }
}

class Description extends StatelessWidget{
  var text = 'Сюжет сериала "Мандалорец" переносит зрителей к событиям, связанными с падением Галактической империи. История берет свое начало с момента, когда империя в финале "Возвращения джедая" потерпела сокрушительное поражение. Временной промежуток взят вплоть до появления Первого Ордена, с которым зрители столкнутся в эпизоде "Пробуждение силы". История же рассказывает об одиноком наемнике-мандалорце, который обитает на краю галактики. Новая Республика еще не распространила свое влияние на эти земли, поэтому здесь творится безумие и беззаконие, в котором персонаж нередко принимает непосредственное участие.';

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 300,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.redAccent,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: DropCapText(
        text,
        dropCap: DropCap(
            width: 110,
            height: 150,
            child: Image.network(
                'http://cdn.bigsv.ru/oblojka/27180.jpg')
        ),
      ),
    );
  }
}