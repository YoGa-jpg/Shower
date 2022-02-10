//import 'dart:html';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/dom_parsing.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
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

class _SearchState extends State<Bar> {
  late SearchBar searchBar;
  late http.Response response;
  late List<MovieCard> cards = [];
  var loading = false;
  var title = '';

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white10,
        title: Text('Поиск' + (title.isNotEmpty ? ': $title' : '')),
        actions: [searchBar.getSearchAction(context)]);
  }

  Future<dom.Document> getDOM(String value) async {
    setState(() {});
    var response = await http.Client()
        .get(Uri.parse("http://seasonvar.ru/search?q=$value"));

    var document = parse(response.body);
    return document;
  }

  void getMovies(String value) async {
    loading = true;
    title = value;
    var document = await getDOM(value);
    var containers = document.getElementsByClassName("pgs-search-wrap");
    List<MovieCard> list = [];

    for (var element in containers) {
      //list.add(element.text);
      list.add(MovieCard(
          image: element
              .getElementsByTagName("img")
              .first
              .attributes["src"]
              .toString(),
          title: element
              .getElementsByClassName("pgs-search-info")
              .first
              .getElementsByTagName("a")
              .first
              .text,
          subtitle: element.getElementsByTagName("p").first.text,
          film: element
              .getElementsByTagName("a")
              .first
              .attributes["href"]
              .toString()));
    }
    cards = list;
    loading = false;
    setState(() {});
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: (loading
          ? SpinKitFadingCube(
              itemBuilder: (BuildContext context, int index) {
                return const DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                );
              },
            )
          : (cards.isNotEmpty
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(8),
                  itemCount: cards.length,
                  itemBuilder: (BuildContext context, int index) {
                    return cards[index];
                  })
              : const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Ничего не найдено',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  )))),
      appBar: searchBar.build(context),
    );
  }
}

class MovieCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String film;

  const MovieCard(
      {Key? key,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.film})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white10,
      child: Container(
        height: 150,
        color: Colors.white10,
        child: Row(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Expanded(
                  child: ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.network(image)),
                  flex: 2,
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ListTile(
                        title: Text(title, style: TextStyle(color: Colors.white)),
                        subtitle: Text(
                          subtitle,
                          maxLines: 4,
                          style: TextStyle(color: Colors.white),
                        ),
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
                                primary: Colors.white),
                            onPressed: () {},
                          ),
                          const SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              flex: 8,
            ),
          ],
        ),
      ),
      elevation: 8,
      margin: const EdgeInsets.all(10),
    );
  }
}
