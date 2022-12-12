import 'package:flutter/material.dart';
import 'package:ecofriend/main.dart';
import 'caloriesburned/caloriesburned.dart';
import 'user/login.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            title: const Text('UserDebug'),
            onTap: () {
              // Route menu ke halaman news
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Tracker'),
            onTap: () {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const TrackingPage()),
              // );
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
            // Route menu ke halaman calories burned 
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const CaloriesBurnedPage()),
              );
            },
          ),
                    ListTile(
            title: const Text('Review'),
            onTap: () {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const ReviewPage()),
              // );
            },
          ),
        ],
      ),
    );
  }
}
