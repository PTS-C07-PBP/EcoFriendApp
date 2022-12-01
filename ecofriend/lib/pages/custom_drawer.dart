import 'package:flutter/material.dart';
import 'package:ecofriend/main.dart';

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