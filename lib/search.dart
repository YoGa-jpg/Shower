//import 'dart:html';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/dom_parsing.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatelessWidget{
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Scaffold(
      body: Bar(),
    ));
  }
}

class Bar extends StatefulWidget {
  const Bar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchState();
  }
}

class _SearchState extends State<Bar>{
  late SearchBar searchBar;
  late http.Response response;
  late List<dynamic> movs = [];

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: const Text('My Home Page'),
        actions: [searchBar.getSearchAction(context)]
    );
  }

  Future<dom.Document> getDOM(String value) async{
    var response = await http.Client().get(Uri.parse("http://seasonvar.ru/search?q=$value"));

    var document = parse(response.body);
    return document;
  }

  void getMovies(String value) async{
    var document = await getDOM(value);
    var containers = document.getElementsByClassName("pgs-search-info");
    var list = [];

    for (var element in containers) {
      list.add(element.text);
    }

    movs = list;
  }
  
  _SearchState() {
    searchBar = SearchBar(
        inBar: false,
        setState: setState,
        onSubmitted: getMovies,
        buildDefaultAppBar: buildAppBar,
    );
  }

  @override
  Widget build(BuildContext context) {
    //return searchBar.build(context);
    return Scaffold(body: ListView.builder(
      scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(8),
        itemCount: movs.length,
        itemBuilder: (BuildContext context, int index) {
          return Text(movs[index], style: TextStyle(fontSize: 22));
        }
    ),
      appBar: searchBar.build(context),);
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child:Container(
        height: 150,
        color: Colors.white,
        child: Row(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Expanded(
                  child:Image.asset("assets/images/marci.jpg"),
                  flex:2 ,
                ),
              ),
            ),
            Expanded(
              child:Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    const Expanded(
                      flex: 5,
                      child: ListTile(
                        title: Text("Сериал Невский 5 сезон онлайн"),
                        subtitle: Text("В жизни майора Павла Семёнова почти ничего не изменилось. Он продолжает трудиться в полиции в качестве начальника. Под его ответственностью весь Центральный район. Полковник Андрей Михайлов, по инициативе начальства, оказывается в округе, знаменитом своими криминальными активами. Этот перевод может изменить его карьеру и жизнь навсегда, ведь у мужчины есть лишь опыт работы в Невском отделе. В новом районе же всё работает по известным правилам улиц - кто сильнее, за тем и правда. Тем временем над Семёновым сгущаются тучи. Им всерьез заинтересовалось ФСБ, в котором считают, что мужчина и есть знаменитый Архитектор, преступник, которого не могут поймать уже несколько лет. Михайлов рад бы помочь приятелю, но не верит ему.", maxLines: 4,),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: const Text("СМОТРЕТЬ"),
                            style: TextButton.styleFrom(
                                primary: Colors.lightGreen
                            ),
                            onPressed: (){},
                          ),
                          const SizedBox(width: 8,)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              flex:8 ,
            ),
          ],
        ),
      ),
      elevation: 8,
      margin: const EdgeInsets.all(10),
    );
  }
}