import 'dart:convert';

import 'package:adityagurjar/models/user.dart';
import 'package:adityagurjar/pages/home_page.dart';
import 'package:adityagurjar/validators.dart';
import 'package:adityagurjar/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../main.dart';

class LogInPage extends StatefulWidget {
  static const route = "/loginPage";
  final String title;
  LogInPage({Key key, this.title}) : super(key: key);

  @override
  _LogInPageState createState() => new _LogInPageState();
}

enum FormType { login, register }

class _LogInPageState extends State<LogInPage> {
  static final formKey = new GlobalKey<FormState>();
  bool autoValidate = false;
  bool isLoading = false;

  String _email = '';
  String _password = '';
  String _name = '';
  String _surname = '';
  String _confirmedPassword = '';
  String _hintText = '';
  FormType _formType = FormType.login;

  @override
  void initState() {
    super.initState();
    isLoading = false;
    autoValidate = false;
  }

  Future<Response> signUp(
      String email, String name, String surname, String password) async {
    var url = 'http://127.0.0.1:8000/api/users/';
    var headers = {"Content-type": "application/json"};
    var json =
        '{"email": "$email","name": "$name","surname": "$surname","password": "$password"}';
    Response response = await post(url, headers: headers, body: json);
    return response;
  }

  Future<Response> logIn(String email, String password) async {
    var url = 'http://127.0.0.1:8000/api/user/';
    var headers = {'Content-Type': 'application/json; charset=UTF-8'};
    var json = '{"email": "$email","password": "$password"}';
    Response response = await post(url, headers: headers, body: json);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'LogIn',
          textAlign: TextAlign.center,
        ),
      ),
      body: Stack(
        children: [body(context), _showCircularProgress()],
      ),
    );
  }

  Widget body(BuildContext context) {
    if (ResponsiveWidget.isSmallScreen(context)) {
      return smallScreen(context);
    }

    return largeScreen(context);
  }

  Widget smallScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            Card(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                      autovalidate: autoValidate,
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: (_formType == FormType.login
                                ? loginForm()
                                : signUpForm()) +
                            [
                              SizedBox(
                                height: 30,
                              )
                            ] +
                            submissionOptions(), // adding two widget lists
                      ))),
            ])),
            hintText(),
          ])),
    );
  }

  Widget largeScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  Card(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                        Container(
                            padding: const EdgeInsets.all(20.0),
                            child: Form(
                                autovalidate: autoValidate,
                                key: formKey,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: (_formType == FormType.login
                                          ? loginForm()
                                          : signUpForm()) +
                                      [
                                        SizedBox(
                                          height: 30,
                                        )
                                      ] +
                                      submissionOptions(), // adding two widget lists
                                ))),
                      ])),
                  hintText(),
                ]))),
      ),
    );
  }

  void register() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
      _hintText = '';
    });
  }

  void signIn() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
      _hintText = '';
    });
  }

  List<Widget> signUpForm() {
    return [
      padded(
          child: TextFormField(
        key: Key('email'),
        decoration: InputDecoration(labelText: 'Email'),
        validator: Validators.emailValidator,
        onChanged: (val) => _email = val,
      )),
      padded(
          child: TextFormField(
        key: Key('name'),
        decoration: InputDecoration(labelText: 'Name'),
        validator: Validators.nameValidator,
        onChanged: (val) => _name = val,
      )),
      padded(
          child: TextFormField(
        key: Key('Surname'),
        decoration: InputDecoration(labelText: 'Surname'),
        autocorrect: false,
        validator: Validators.surnameValidator,
        onChanged: (val) => _surname = val,
      )),
      padded(
          child: TextFormField(
        key: Key('password'),
        decoration: InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: Validators.passwordValidator,
        onChanged: (val) => _password = val,
      )),
      padded(
          child: TextFormField(
        key: Key('confirmPassword'),
        decoration: InputDecoration(labelText: 'Confirm password'),
        obscureText: true,
        validator: (value) {
          assert(value != null);
          if (value != _password) {
            return 'Passwords dont match';
          }
          return null;
        },
        onChanged: (val) => _confirmedPassword = val,
      )),
    ];
  }

  List<Widget> loginForm() {
    return [
      padded(
          child: TextFormField(
        key: Key('email'),
        decoration: InputDecoration(labelText: 'Email'),
        validator: Validators.emailValidator,
        onChanged: (val) => _email = val,
      )),
      padded(
          child: TextFormField(
        key: Key('password'),
        decoration: InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: Validators.passwordValidator,
        onChanged: (val) => _password = val,
      )),
    ];
  }

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

  List<Widget> submissionOptions() {
    switch (_formType) {
      case FormType.login:
        return [
          MaterialButton(
              key: Key('login'),
              child: Text('Login'),
              height: 44.0,
              color: Colors.blue,
              onPressed: () async {
                if (formKey.currentState.validate()) {
                  setState(() {
                    isLoading = true;
                  });
                  var response = await logIn(_email, _password);
                  switch (response.statusCode) {
                    case 200:
                      MyApp.user = User.fromJson(jsonDecode(response.body));
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          HomePage.route, (Route<dynamic> route) => false);
                      break;
                    case 404:
                      setState(() {
                        isLoading = false;
                        _hintText = 'User doesn\'t exist';
                      });
                      break;
                    default:
                      setState(() {
                        isLoading = false;
                      });
                      break;
                  }
                } else {
                  setState(() {
                    autoValidate = true;
                  });
                }
              }),
          SizedBox(
            height: 10,
          ),
          FlatButton(
              key: Key('signUp'),
              child: Text(
                "Need an account? Sign Up",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onPressed: register),
        ];
      case FormType.register:
        return [
          MaterialButton(
              key: Key('create_account'),
              child: Text('Sign Up'),
              height: 44.0,
              color: Colors.blue,
              onPressed: () async {
                if (formKey.currentState.validate()) {
                  setState(() {
                    isLoading = true;
                  });
                  var response =
                      await signUp(_email, _name, _surname, _password);
                  switch (response.statusCode) {
                    case 200:
                      var res = await logIn(_email, _password);
                      MyApp.user = User.fromJson(jsonDecode(res.body));
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          HomePage.route, (Route<dynamic> route) => false);
                      break;
                    case 400:
                      setState(() {
                        isLoading = false;
                        _hintText = 'User already exists';
                      });
                      break;
                    default:
                      setState(() {
                        isLoading = false;
                      });
                      break;
                  }
                } else {
                  setState(() {
                    autoValidate = true;
                  });
                }
              }),
          SizedBox(
            height: 10,
          ),
          FlatButton(
              key: Key('sign_in'),
              child: Text(
                "Registered already ? Login",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onPressed: signIn),
        ];
    }
    return null;
  }

  Widget hintText() {
    return Container(
        padding: const EdgeInsets.all(32.0),
        child: new Text(_hintText,
            key: Key('hint_text'),
            style: TextStyle(fontSize: 18.0, color: Colors.red),
            textAlign: TextAlign.center));
  }

  Widget padded({Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: child,
    );
  }
}
