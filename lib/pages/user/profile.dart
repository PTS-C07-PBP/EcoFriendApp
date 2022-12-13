import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../custom_drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  final String title = 'EcoUser Profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _loginFormKey = GlobalKey<FormState>();
  String username = "";
  String firstName = "";
  String lastName = "";
  String email = "";
  String statusMessage = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    fetchData(request);
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
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Username : ", style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'Lobster')),
            Text(
                "$username",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            SizedBox(height: 10),
            Text("First Name : ", style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'Lobster')),
            Text(
              "$firstName",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(height: 10),
            Text("Last Name : ", style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'Lobster')),
            Text(
              "$lastName",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(height: 10),
            Text("Email : ", style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'Lobster')),
            Text(
              "$email",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Container(
              height: 80,
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text('Log Out'),
                  onPressed: () async {
                    final response = await request.logout(
                        "https://ecofriend.up.railway.app/authentication/logout/",);

                      if (!response["status"]) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Logged out. See you again!"),
                        ));
                        Navigator.pushNamed(context, '/');
                      } else {
                        setState(() {
                          statusMessage = "Something went wrong, try again.";
                        });
                      }
                    }
                  )),
            Text(statusMessage),
          ],
        ),
      )
    );
  }

  Future<void> fetchData(CookieRequest request) async {
    var res = await request.get(
      'https://ecofriend.up.railway.app/authentication/profile',
    );

    // melakukan konversi data json menjadi object Footprint
    setState(() {
      username = res['data']['username'];
      firstName = res['data']['first_name'];
      lastName = res['data']['last_name'];
      email = res['data']['email'];
    });
    return;
  }
}
