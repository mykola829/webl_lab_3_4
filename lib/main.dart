import 'package:adityagurjar/models/comment.dart';
import 'package:adityagurjar/models/news_model.dart';
import 'package:adityagurjar/pages/home_page.dart';
import 'package:adityagurjar/pages/login_page.dart';
import 'package:adityagurjar/pages/root_page.dart';
import 'package:adityagurjar/widgets/theme_inherited_widget.dart';
import 'package:flutter/material.dart';

import 'config/themes.dart';
import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  static User user;
  static List<News> news;
  static List<Comment> comments;

  @override
  Widget build(BuildContext context) {
    return ThemeSwitcherWidget(
      initialDarkModeOn: false,
      child: InitPage(),
    );
  }
}

class InitPage extends StatelessWidget {
  const InitPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mykola Romanyshyn',
      theme: ThemeSwitcher.of(context).isDarkModeOn
          ? darkTheme(context)
          : lightTheme(context),
      initialRoute: RootPage.route,
      routes: {
        LogInPage.route: (context) => LogInPage(),
        HomePage.route: (context) => HomePage(),
        RootPage.route: (context) => RootPage(),
      },
    );
  }
}
