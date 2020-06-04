import 'package:adityagurjar/config/assets.dart';
import 'package:adityagurjar/main.dart';
import 'package:adityagurjar/tabs/home_tab.dart';
import 'package:adityagurjar/tabs/news_tab.dart';
import 'package:adityagurjar/widgets/theme_inherited_widget.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  static const route = "/homePage";
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static String categoryAPI = '';
  static List<Widget> tabWidgets = <Widget>[
    NewsTab(),
    HomeTab(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: MyApp.user == null
              ? Text(
                  'News',
                  style: TextStyle(fontSize: 22),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        MyApp.user != null ? 'Email: ' + MyApp.user.email : "",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        MyApp.user != null ? 'Name: ' + MyApp.user.name : "",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        MyApp.user != null
                            ? 'Surname: ' + MyApp.user.surname
                            : "",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
          actions: <Widget>[
            MyApp.user != null
                ? MaterialButton(
                    padding: const EdgeInsets.only(right: 5),
                    onPressed: () {
                      MyApp.user = null;
                      setState(() {});
                      Navigator.of(context).pushNamed(LogInPage.route);
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : MaterialButton(
                    padding: const EdgeInsets.only(right: 5),
                    onPressed: () {
                      Navigator.of(context).pushNamed(LogInPage.route);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
            IconButton(
              icon: ThemeSwitcher.of(context).isDarkModeOn
                  ? Icon(Icons.wb_sunny)
                  : Image.asset(
                      Assets.moon,
                      height: 20,
                      width: 20,
                    ),
              onPressed: () => ThemeSwitcher.of(context).switchDarkMode(),
            )
          ],
        ),
        body: Center(
          child: tabWidgets.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.chrome_reader_mode),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              title: Text('Categories'),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          selectedItemColor: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
