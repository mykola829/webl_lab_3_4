import 'package:adityagurjar/models/news_model.dart';
import 'package:adityagurjar/widgets/news_widget.dart';
import 'package:adityagurjar/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class NewsTab extends StatefulWidget {
  @override
  _NewsTabState createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  bool _showError = false;
  List<News> _news = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < MyApp.news.length; i++) {
      var news = MyApp.news[i];
      if (news.category == 'top') {
        _news.add(news);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_showError) {
      Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Something went wrong',
              style: Theme.of(context).textTheme.headline,
            ),
          ),
        ],
      ));
    }
    return ResponsiveWidget(
      largeScreen: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: blogList(),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          )
        ],
      ),
      smallScreen: blogList(),
    );
  }

  Widget blogList() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListView.builder(
                itemCount: _news.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>
                    NewsWidget(_news[index], index, _news.length, false)),
          ],
        ),
      ),
    );
  }
}
