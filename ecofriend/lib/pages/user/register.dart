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
  String? _role = 'EcoUser';
  final List<String> _listRole = [
    'Admin',
    'EcoUser',
  ];
  String _description = '';

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
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height,
            child: Column(
              children: [
                Padding(
                  // Input Title
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffffffff),
                      labelText: "Title",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),

                    // Update variabel title
                    onChanged: (String? value) {
                      setState(() {
                        _username = value!;
                      });
                    },
                    onSaved: (String? value) {
                      setState(() {
                        _username = value!;
                      });
                    },

                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Title cannot be empty!';
                      }
                      return null;
                    },
                  ),
                ),
                
                Padding(
                  // Input description
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    maxLines: 6,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffffffff),
                      labelText: "Description",
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),

                    // Update variabel description
                    onChanged: (String? value) {
                      setState(() {
                        _description = value!;
                      });
                    },
                    onSaved: (String? value) {
                      setState(() {
                        _description = value!;
                      });
                    },

                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Description cannot be empty!';
                      }
                      return null;
                    },
                  ),
                ),
                const Spacer(),
                SizedBox(
                    width: 150,
                    height: 50,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff00fc97)),
                      ),
                      onPressed: () {
                        if (_registerFormKey.currentState!.validate()) {
                          postArticle(request);
                          print(_username);
                          print(_role);
                          print(_description);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Register New EcoUser",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void postArticle(CookieRequest request) async {
    //TODO: Tunggu authenticate
    var url = Uri.parse('https://ecofriend.up.railway.app/news/add/');

    var response = await request.post(
        'https://ecofriend.up.railway.app/news/add/',
        jsonEncode({'title': _username, 'region': _role, 'description': _description}));
  }
}