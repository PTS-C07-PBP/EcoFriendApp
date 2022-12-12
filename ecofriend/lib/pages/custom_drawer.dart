import 'package:ecofriend/pages/tracker/tracker.dart';
import 'package:flutter/material.dart';
import 'package:ecofriend/main.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'user/login.dart';
import 'user/profile.dart';
import 'review/review_index.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Drawer(
      backgroundColor: const Color(0xffcfffcc),
      child: Column(
        children: [
          // Menambahkan menu click
          ListTile(
            title: const Text('News'),
            onTap: () {
              // Route menu ke halaman news
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const NewsPage()),
              );
            },
          ),
          ListTile(
            title: const Text('EcoUser'),
            onTap: () {
              // Route menu ke halaman news
              if (request.loggedIn == false) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              }
            },
          ),
          ListTile(
            title: const Text('Tracker'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const TrackerPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Ranking'),
            onTap: () {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const RankingPage()),
              // );
            },
          ),
          ListTile(
            title: const Text('Calories Burned'),
            onTap: () {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const CaloriesBurnedPage()),
              // );
            },
          ),
          ListTile(
            title: const Text('Review'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ReviewPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
