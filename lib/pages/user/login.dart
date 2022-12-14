import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../custom_drawer.dart';
import 'register.dart';

var newValue = {};

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  final String title = 'EcoUser Login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();

  String statusMessage = "";
  String _username = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
        backgroundColor: const Color(0xffcfffcc),
        appBar: AppBar(
          title: const Text(
            'EcoUser Login',
            style: TextStyle(
                color: Colors.black, fontFamily: 'Lobster', fontSize: 23),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        drawer: const CustomDrawer(),
        body: Form(
          key: _loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // TODO: tambahin logo
              // Container(
              //   padding: const EdgeInsets.all(20, 20, 20, 70),
              //   child: FlutterLogo(
              //     size: 40,
              //   ),
              // ),
              Container(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    labelText: 'Username',
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _username = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is required!';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    labelText: 'Password',
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _password = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required!';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                  height: 80,
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text('Log In'),
                      onPressed: () async {
                        if (_loginFormKey.currentState!.validate()) {
                          final response = await request.login(
                              "https://ecofriend.up.railway.app/authentication/login/",
                              {
                                'username': _username,
                                'password': _password,
                              }).then((value) {
                            newValue = Map<String, dynamic>.from(value);

                            setState(() {
                              if (newValue['message'].toString() ==
                                  "Failed to Login, check your email/password.") {
                                statusMessage = "Invalid username/password!";
                              } else {
                                statusMessage = newValue['message'].toString();
                              }
                            });
                          });
                          if (request.loggedIn) {
                            // Code here will run if the login succeeded.
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Login success!"),
                            ));
                            Navigator.pushNamed(context, '/');
                          }
                        }
                      })),
              Text(statusMessage),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()),
                  );
                },
                child: const Text(
                  'Not an EcoUser yet? Register Now!',
                  style: TextStyle(color: Color(0xff757575)),
                ),
              ),
            ],
          ),
        ));
  }
}
