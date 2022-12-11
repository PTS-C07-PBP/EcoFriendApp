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
      title: 'Add Footprint',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff00fc97),
            primary: const Color(0xff00fc97)),
      ),
      home: const AddFootprintPage(),
    );
  }
}

class AddFootprintPage extends StatefulWidget {
  const AddFootprintPage({super.key});
  final String title = 'Add Carbon Footprint History';

  @override
  State<AddFootprintPage> createState() => _AddFootprintPageState();
}

class _AddFootprintPageState extends State<AddFootprintPage> {

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
      body: Form(),

    );
  }

