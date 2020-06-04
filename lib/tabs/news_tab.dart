import 'package:adityagurjar/config/constants.dart';
import 'package:adityagurjar/models/news_model.dart';
import 'package:adityagurjar/widgets/news_widget.dart';
import 'package:adityagurjar/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool _loadingData = true;
  bool _showError = false;
  String category;
  List<News> _news = [];
  @override
  void initState() {
    super.initState();
        _news.clear();

    category = 'business';
    loadBlogs(category);
  }

  void changeCategory(int index) {
    String category;
    switch (index) {
      case 0:
        category = "business";
        break;
      case 1:
        category = "entertainment";

        break;
      case 2:
        category = "health";

        break;
      case 3:
        category = "science";

        break;
      case 4:
        category = "sport";

        break;
      case 5:
        category = "technology";

        break;
      default:
    }
    _news.clear();
    
    loadBlogs(category);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
              bottom: TabBar(
            onTap: (index) => setState(() => changeCategory(index)),
            isScrollable: true,
            tabs: [
              Tab(
                text: 'Business',
              ),
              Tab(
                text: 'Entertainment',
              ),
              Tab(
                text: 'Health',
              ),
              Tab(
                text: 'Science',
              ),
              Tab(
                text: 'Sport',
              ),
              Tab(
                text: 'Technology',
              ),
            ],
          )),
          body: _loadingData
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _showError
                  ? Center(
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
                        RaisedButton(
                          child: Text(
                            'Retry',
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .copyWith(color: Colors.white),
                          ),
                          elevation: 0.0,
                          onPressed: () => loadBlogs(Constants.NEWS_API),
                        )
                      ],
                    ))
                  : ResponsiveWidget(
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
                    ),
        ));
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

  void loadBlogs(String category) async {
    setState(() {
      _loadingData = true;
      _showError = false;
    });
    for (var i = 0; i < MyApp.news.length; i++) {
      var news = MyApp.news[i];
      if (news.category == category) {
        print(news.id);
        _news.add(news);
      }
    }
    setState(() {
      if (_news == null) {
        _showError = true;
        _loadingData = false;
      } else {
        _showError = false;
        _loadingData = false;
      }
    });
  }
}
