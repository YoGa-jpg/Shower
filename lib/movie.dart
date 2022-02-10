import 'package:flutter/cupertino.dart';
import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class MoviePage extends StatelessWidget {
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
        backgroundColor: Colors.black87,
        body: Column(
          children: [
            Description(),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                          onPressed: _launchURL,
                          child: const Text(
                            "Смотреть",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 36,
                                color: Colors.black),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(24.0))))),
                    ))),
          ],
        ),
        appBar:
            AppBar(title: Text('Мандалорец'), backgroundColor: Colors.white10),
      ),
    );
  }
}

class Description extends StatelessWidget {
  var text =
      'Сюжет сериала "Мандалорец" переносит зрителей к событиям, связанными с падением Галактической империи. История берет свое начало с момента, когда империя в финале "Возвращения джедая" потерпела сокрушительное поражение. Временной промежуток взят вплоть до появления Первого Ордена, с которым зрители столкнутся в эпизоде "Пробуждение силы". История же рассказывает об одиноком наемнике-мандалорце, который обитает на краю галактики. Новая Республика еще не распространила свое влияние на эти земли, поэтому здесь творится безумие и беззаконие, в котором персонаж нередко принимает непосредственное участие.';

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 300,
      decoration: const BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: DropCapText(
        text,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        dropCap: DropCap(
            width: 110,
            height: 150,
            child: ClipRRect(
              child: Image.network('http://cdn.bigsv.ru/oblojka/27180.jpg'),
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );
  }
}
