import 'dart:convert';

import 'package:adityagurjar/models/comment.dart';
import 'package:adityagurjar/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../main.dart';
import 'home_page.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
  static const route = "/rootPage";
}

class _RootPageState extends State<RootPage> {
  bool isLoading = true;
  Widget _showCircularProgress() {
    if (isLoading) {
      return Container(
          color: Theme.of(context).primaryColor,
          height: double.infinity,
          width: double.infinity,
          child: Align(
              alignment: Alignment.center, child: CircularProgressIndicator()));
    } else {
      return Container();
    }
  }

  Future<int> downloadArticles() async {
    var url = 'http://127.0.0.1:8000/api/articles/';
    var response = await get(url).then((value) {
      List news = json.decode(utf8.decode(value.bodyBytes))['articles'];
      final results = news
          .map((i) => News.fromJson(i))
          .where((element) =>
              element.author != null &&
              element.description != null &&
              element.name != null &&
              element.url != null &&
              element.urlToImage != null &&
              element.content != null &&
              element.publishedAt != null &&
              element.title != null)
          .toList();
      MyApp.news = results;
    });
  }

  Future<int> downloadComments() async {
    var url = 'http://127.0.0.1:8000/api/comments/';
    var response = await get(url).then((value) {
      print(value.body);
      List comments = json.decode(utf8.decode(value.bodyBytes))['comments'];
      final results = comments.map((i) => Comment.fromJson(i)).toList();
      MyApp.comments = results;
      for (var i in MyApp.comments) {
        print(i.id);
      }

      Navigator.pushNamedAndRemoveUntil(
          context, HomePage.route, (route) => false);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    downloadArticles().then((value) => downloadComments());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _showCircularProgress(),
    );
  }
}
