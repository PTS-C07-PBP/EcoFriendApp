
import 'package:ecofriend/pages/review/review_index.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import 'package:ecofriend/pages/user/login.dart';
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
      home: const AddReviewPage(),
    );
  }
}

class AddReviewPage extends StatefulWidget {
  const AddReviewPage({super.key});
  final String title = 'Add Review';

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  final List<int> _ratingList = [1, 2, 3, 4, 5];
  int _rating = 5;
  String _description = '';
  String _statusMessage = '';

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
        key: _formKey,
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
                  // Input Rating
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffffffff),
                      labelText: "Rating",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Color(0xff000000),
                    ),
                    value: _rating,
                    items: _ratingList.map((int value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Row(children: List.generate(value, (index) => const Icon(Icons.star, color: Color(0xff00fc97),)))
                      );
                    }).toList(),
                    onChanged: (int? value) {
                      setState(() {
                        _rating = value!;
                      });
                    },
                    onSaved: (int? value) {
                      setState(() {
                        _rating = value!;
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
                Text(_statusMessage),
                SizedBox(
                    width: 150,
                    height: 50,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff00fc97)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          postReview(request);
                        }
                      },
                      child: const Text(
                        "Add Review",
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

  void postReview(CookieRequest request) async {
    if (request.loggedIn == false) {
      setState(() {
        _statusMessage = 'You must login first!';
      });
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
      return;
    }

    var crsfToken = request.headers['cookie']!
        .split(';')
        .firstWhere((element) => element.startsWith('csrftoken'))
        .split('=')[1];

    if (_formKey.currentState!.validate()) {
      // post using http to https://ecofriend.up.railway.app/review/addreview/
      final response = await request.post(
        'https://ecofriend.up.railway.app/review/addreview/',
        {
          'title': _title,
          'rating': _rating.toString(),
          'description': _description,
          'csrfmiddlewaretoken': crsfToken,
        },
      );

      if (response != null )
      {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ReviewPage()),
        );
      }
    }
  }
}
