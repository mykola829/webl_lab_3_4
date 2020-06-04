import 'package:adityagurjar/models/comment.dart';
import 'package:adityagurjar/models/news_model.dart';
import 'package:adityagurjar/widgets/responsive_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:http/http.dart';

import '../main.dart';

class NewsDetail extends StatefulWidget {
  final News news;
  NewsDetail({Key key, @required this.news, String id}) : super(key: key);

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  String text;
  News news;
  List<Comment> comments = new List<Comment>();

  Future<Response> postComment(String text, String author, int article) async {
    var url = 'http://127.0.0.1:8000/api/comments/';
    var headers = {'Content-Type': 'application/json; charset=UTF-8'};
    var json = '{"text": "$text","author": "$author", "article" : "$article"}';
    Response response = await post(url, headers: headers, body: json);
    return response;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    news = widget.news;
    for (var i = 0; i < MyApp.comments.length; i++) {
      var comment = MyApp.comments[i];
      if (comment.article == news.id) {
        comments.add(comment);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Scaffold(
            appBar: AppBar(
              title: Text(news.title),
              elevation: 0.0,
            ),
            body: ResponsiveWidget(
              largeScreen: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 2,
                    child: blogList(context),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  )
                ],
              ),
              smallScreen: blogList(context),
            )));
  }

  Widget blogList(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              news.urlToImage,
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              "Author: ${news.author}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              "${news.content}",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'See more ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'here',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            if (news.url != null)
                              html.window.open(news.url, 'news');
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            MyApp.user != null
                ? TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                            icon: Icon(Icons.touch_app),
                            onPressed: () async {
                              var coms = MyApp.comments;
                              coms.add(new Comment(
                                  coms.last.id + 1,
                                  text,
                                  MyApp.user.name + ' ' + MyApp.user.surname,
                                  news.id));
                              var response = await postComment(
                                  text,
                                  MyApp.user.name + ' ' + MyApp.user.surname,
                                  news.id);
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewsDetail(
                                    news: news,
                                  ),
                                ),
                              );
                            })),
                    maxLength: 250,
                    onChanged: (value) {
                      setState(() {
                        text = value;
                      });
                    },
                  )
                : Container(),
            ExpansionTile(
              leading: Icon(Icons.comment),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(comments.length.toString()),
              ]),
              title: Text("Comments"),
              children: List<Widget>.generate(
                  comments.length,
                  (int index) => ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.person_pin),
                        ),
                        subtitle: Text(comments[index].text),
                        title: Text(comments[index].author),
                      )),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
