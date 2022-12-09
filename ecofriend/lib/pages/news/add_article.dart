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
    return MaterialApp(
      title: 'Add Article',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff00fc97),
            primary: const Color(0xff00fc97)),
      ),
      home: const AddArticlePage(),
    );
  }
}

class AddArticlePage extends StatefulWidget {
  const AddArticlePage({super.key});
  final String title = 'Add Article';

  @override
  State<AddArticlePage> createState() => _AddArticlePageState();
}

class _AddArticlePageState extends State<AddArticlePage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String? _region = 'global';
  final List<String> _listRegion = [
    'global',
    'africa',
    'middle east',
    'europe',
    'americas',
    'asia pacific'
  ];
  String _description = '';

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      backgroundColor: const Color(0xfff3fcf2),
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
        key: _formKey,
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
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Color(0xff198754))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Color(0xff198754))),
                    focusColor: const Color(0xff198754),
                  ),
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),

                  // Update variabel title
                  onChanged: (String? value) {
                    setState(() {
                      _title = value!;
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      _title = value!;
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
                // Dropdown region
                padding: const EdgeInsets.all(10.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffffffff),
                    labelText: "Region",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Color(0xff198754))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Color(0xff198754))),
                    focusColor: const Color(0xff198754),
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                  value: _region,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: _listRegion.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items.splitMapJoin(RegExp(r' '),
                          onMatch: (m) => ' ',
                          onNonMatch: (m) =>
                              m[0].toUpperCase() + m.substring(1))),
                    );
                  }).toList(),
                  hint: const Text('Region'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _region = newValue!;
                    });
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
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Color(0xff198754))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Color(0xff198754))),
                    focusColor: const Color(0xff198754),
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
                          MaterialStateProperty.all(const Color(0xffcfffcc)),
                          shadowColor: MaterialStateProperty.all(const Color(0xff000000)),
                          elevation: MaterialStateProperty.all(2),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        postArticle(request);
                        Navigator.pop(context);
                      }
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add, color: Colors.black),
                          Text(
                            "Add Article",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ]),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void postArticle(CookieRequest request) async {
    //TODO: Tunggu authenticate
    var response = await request.post(
        'https://ecofriend.up.railway.app/news/add/',
        jsonEncode(
            {'title': _title, 'region': _region, 'description': _description}));
  } //'https://ecofriend.up.railway.app/news/add/'
}
