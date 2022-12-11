import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../custom_drawer.dart';
import 'dart:convert';

const List<Widget> transportations = <Widget>[
  Text('Car', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
  Text('Motorcycle',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
  Text('On foot', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))
];

void main() {
  runApp(const MyApp());
}

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
  final _formKey = GlobalKey<FormState>();
  String _mileage = "";
  List<bool> isSelected = [true, false, false];

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
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Example: 1,5",
                    labelText: "How far did you travel? (in kilometer)",
                    // Menambahkan circular border agar lebih rapi
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),

                  // update var
                  onChanged: (String? value) {
                    setState(() {
                      _mileage = value!;
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      _mileage = value!;
                    });
                  },

                  // Validator sebagai validasi form
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Mileage can't be empty!";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
                    TextInputFormatter.withFunction(
                      (oldValue, newValue) => newValue.copyWith(
                        text: newValue.text.replaceAll('.', ','),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    'What transportation did you use?',
                    style: TextStyle(fontSize: 20),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ToggleButtons(
                    onPressed: (int index) {
                      setState(() {
                        // The button that is tapped is set to true, and the others to false.
                        for (int i = 0; i < isSelected.length; i++) {
                          isSelected[i] = i == index;
                        }
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    constraints: const BoxConstraints(
                      minHeight: 50.0,
                      minWidth: 150.0,
                    ),
                    isSelected: isSelected,
                    children: transportations),
              ),
            ]),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 80,
              height: 50,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xff00fc97)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    postFootprint(request);
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Add",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              width: 80,
              height: 50,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xff00fc97)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Back",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void postFootprint(CookieRequest request) async {
    var type = 'jalan';
    if (isSelected[0] == true)
      type = 'mobil';
    else if (isSelected[1] == true) type = 'motor';

    var crsfToken = request.headers['cookie']!
        .split(';')
        .firstWhere((element) => element.startsWith('csrftoken'))
        .split('=')[1];

    var response =
        request.post('https://ecofriend.up.railway.app/tracker/add_footprint', {
      'mileage': _mileage.toString(),
      'type': type,
      'csrfmiddlewaretoken': crsfToken,
    });
    if (response != null) {
      // Code here will run if the login succeeded.
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Footprint added"),
      ));
    }
  }
}
