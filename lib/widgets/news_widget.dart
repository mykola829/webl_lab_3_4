import 'package:adityagurjar/pages/newsDetail.dart';
import 'package:flutter/material.dart';

class NewsWidget extends StatelessWidget {
  final news;
  final index;
  final length;
  bool isLiked = false;

  NewsWidget(this.news, this.index, this.length, this.isLiked);
  @override
  Widget build(BuildContext context) {
    double topBottomPadding = (index == 0 || index == length - 1) ? 16.0 : 8.0;
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              NewsDetail(news: news),
        ),
      ),
      child: Card(
        margin:
            EdgeInsets.fromLTRB(16.0, topBottomPadding, 16.0, topBottomPadding),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              news.urlToImage != null
                  ? Image.network(news.urlToImage)
                  : Container(),
              SizedBox(
                height: 16,
              ),

              SizedBox(
                height: 8,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        news.title,
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                  ]),
              Text(news.name, style: Theme.of(context).textTheme.subtitle),
              SizedBox(
                width: 100,
              ),

              //Text(blog.virtuals.totalClapCount)
            ],
          ),
        ),
      ),
    );
  }
}
