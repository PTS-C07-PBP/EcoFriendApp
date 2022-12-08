import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import '../custom_drawer.dart';

void main() {
  runApp(const MyApp());
}
// rgb(0, 252, 151) rgb(207, 255, 204)

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) {
            CookieRequest request = CookieRequest();
            return request;
        },
        child: MaterialApp(
        title: 'Register',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xff00fc97),
              primary: const Color(0xff00fc97)),
        ),
        home: const RegisterPage(),
      )
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  final String title = 'Register EcoUser';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();

  String _email = "";
  String _username = "";
  String _firstname = "";
  String _lastname = "";
  String _password1 = "";
  String _password2 = "";
  String? _role = 'EcoUser';
  final List<String> _listRole = [
    'Admin',
    'EcoUser',
  ];

  String statusMessage = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      backgroundColor: const Color(0xffcfffcc),
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
              color: Colors.black, fontFamily: 'Lobster', fontSize: 23),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: const CustomDrawer(),
      body: Form(
        key: _registerFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                    setState((){
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  labelText: 'First Name',
                ),
                onChanged: (String? value) {
                    setState((){
                        _firstname = value!;
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  labelText: 'Last Name',
                ),
                onChanged: (String? value) {
                    setState((){
                        _firstname = value!;
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
                    setState((){
                        _password1 = value!;
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
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  labelText: 'Password Confirmation',
                ),

                onChanged: (String? value) {
                    setState((){
                        _password2 = value!;
                    });
                },
                validator: (String? value) {
                    if (value == null || value.isEmpty) {
                        return 'Password is required!';
                    }

                    if (value != _password1) {
                        return 'Password not matched!';
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
                    if (_registerFormKey.currentState!.validate()) {
                      final response = await request.login("https://ecofriend.up.railway.app/authentication/login/", {
                                                    'username': _username,
                                                    'password': _password1,
                      }).then((value) {
                        final newValue = new Map<String, dynamic>.from(value);
                        print(newValue['message']);

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
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Login success!"),
                        ));
                          Navigator.pushNamed(context, '/');
                      }
                      // else {
                      //   // Code here will run if the login failed (wrong username/password).
                      //   showDialog(context: context, 
                      //   builder: (context) {
                      //     return Dialog (
                      //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      //       elevation: 10,
                      //       child: Container(
                      //         child: ListView(
                      //           padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      //           shrinkWrap: true,
                      //           children: <Widget>[
                      //             const Center(
                      //                 child: Text(
                      //                     'Username or Password is wrong',
                      //                     style: TextStyle(
                      //                         fontSize: 24,
                      //                         fontWeight: FontWeight.bold
                      //                     ),
                      //                 )
                      //             ),
                      //             const SizedBox(height: 20),
                      //             TextButton(
                      //                 onPressed: () {
                      //                     Navigator.pop(context);
                      //                 },
                      //                 child: const Text('Try again'),
                      //             )
                      //           ]
                      //         )
                      //       )
                      //       );
                      //   });
                      // }
                    }
                  }
                )),
            Text(statusMessage),
          ],
        ),
      ),
    );
  }
}