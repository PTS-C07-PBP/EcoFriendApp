import 'package:ecofriend/main.dart';
import 'package:ecofriend/models/caloriesburned/person.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import '../custom_drawer.dart';

class AddWeightPage extends StatefulWidget {
  const AddWeightPage({super.key});

  @override
  State<AddWeightPage> createState() => _AddWeightPageState();
}

class _AddWeightPageState extends State<AddWeightPage> {
  final _formKey = GlobalKey<FormState>();
  double _weight = 0;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
        appBar: AppBar(
          title: Text('Add Weight'),
        ),
        drawer: const CustomDrawer(),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.00),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "60",
                        labelText: "Berapa berat badan anda (dalam kilogram)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _weight = double.parse(value!);
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Berat tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      onPressed: () async {
                        print(_weight);
                        final response = await request.post(
                            "https://ecofriend.up.railway.app/caloriesburned/add_person/",
                            {
                              'weight': "$_weight",
                            });
                        final snackbar = SnackBar(
                          content:
                              const Text("Yay! Your motivation has beed added"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        Navigator.pop(context);
                      },
                      child: const Text("Simpan"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
