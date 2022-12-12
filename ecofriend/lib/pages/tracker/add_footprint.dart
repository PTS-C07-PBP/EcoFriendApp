import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:ecofriend/pages/tracker/tracker.dart';
import '../custom_drawer.dart';

const List<Text> transportations = <Text>[
  Text('Car', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
  Text('Motorcycle',
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
  Text('On foot', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600))
];

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

void main() {
  runApp(const MyApp());
}
// rgb(0, 252, 151) rgb(207, 255, 204)

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Carbon Footprint',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff00fc97),
            primary: const Color(0xff00fc97)),
      ),
      scaffoldMessengerKey: snackbarKey,
      home: const AddFootprintPage(),
    );
  }
}

class AddFootprintPage extends StatefulWidget {
  const AddFootprintPage({super.key});
  final String title = 'Add Carbon Footprint';

  @override
  State<AddFootprintPage> createState() => _AddFootprintPageState();
}

class _AddFootprintPageState extends State<AddFootprintPage> {
  final _formKey = GlobalKey<FormState>();
  String _mileage = '';
  String _type = 'mobil';
  List<bool> isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    ]),
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
                      minWidth: 100.0,
                    ),
                    isSelected: isSelected,
                    children: transportations),
              ),
            ],
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
                    if (isSelected[1] == true)
                      _type = 'motor';
                    else if (isSelected[2] == true) _type = 'jalan';
                    postFootprint(request);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Footprint added!"),
                    ));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TrackerPage()),
                    );
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
    // add history
    var csrfToken = request.headers['cookie']!
        .split(';')
        .firstWhere((element) => element.startsWith('csrftoken'))
        .split('=')[1];
    var response = await request.post(
      'https://ecofriend.up.railway.app/tracker/add_footprint',
      {'mileage': _mileage, 'type': _type, 'csrfmiddlewaretoken': csrfToken},
    );
  }
}
