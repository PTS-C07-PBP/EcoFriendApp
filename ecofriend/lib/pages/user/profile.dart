import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../custom_drawer.dart';
import 'register.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  final String title = 'EcoUser Profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      backgroundColor: const Color(0xffcfffcc),
      appBar: AppBar(
        title: const Text('EcoUser Profile',
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
            Container(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  labelText: 'Username',
                ),
                validator: (String? value) {
                    if (value == null || value.isEmpty) {
                        return 'Username is required!';
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
                onPressed: () {
                  
                }
              ) 
            ),
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
      )
    );
  }

  // void postArticle(CookieRequest request) async {
  //   //TODO: Tunggu authenticate
  //   var url = Uri.parse('https://ecofriend.up.railway.app/news/add/');

  //   var response = await request.post(
  //       'https://ecofriend.up.railway.app/news/add/',
  //       jsonEncode({'title': _title, 'region': _region, 'description': _description}));
  // }
}
