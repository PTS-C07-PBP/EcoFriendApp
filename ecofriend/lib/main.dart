import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import 'pages/custom_drawer.dart';
import 'pages/custom_color.dart';
import 'pages/news/add_article.dart';
import 'models/article.dart';

void main() {
  runApp(const MyApp());
}
// rgb(0, 252, 151) rgb(207, 255, 204)

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'News',
        theme:
            ThemeData(primarySwatch: addMaterialColor(const Color(0xff00fc97))),
        home: const NewsPage(),
        routes: {
          "/addArticle": (BuildContext context) => const AddArticlePage(),
        },
      ),
    );
  }
}

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});
  final String title = 'News';

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int _pageNum = 1;
  bool _firstTime = true;
  int _thisPageNum = 1;
  String? _thisRegion = 'all';
  final List<String> _listRegion = [
    'all',
    'global',
    'africa',
    'middle%20east',
    'europe',
    'americas',
    'asia%20pacific'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
              color: Colors.black, fontFamily: 'Lobster', fontSize: 23),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: const CustomDrawer(),
      body: FutureBuilder(
          future: _firstTime ? initArticle() : fetchArticle(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (!snapshot.hasData) {
                return Column(
                  children: const [
                    Text(
                      "Tidak ada article.",
                      style: TextStyle(color: Color(0x00000000), fontSize: 20),
                    ),
                    SizedBox(height: 8),
                  ],
                );
              } else {
                // Make cards
                return makeCards(snapshot);
              }
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: addArticle,
        tooltip: 'Add Article',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<List<Article>> initArticle() async {
    // Init pertama kali
    var url = Uri.parse('https://ecofriend.up.railway.app/news/init/');

    var response = await http.get(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Article
    List<Article> listArticle = [];
    for (var d in data[0]) {
      if (d != null) {
        listArticle.add(Article.fromJson(d));
      }
    }
    _pageNum = data[1];
    return listArticle;
  }

  Future<List<Article>> fetchArticle() async {
    // Fetch article
    var url = Uri.parse(
        'https://ecofriend.up.railway.app/news/articles/?region=$_thisRegion&&page_num=$_thisPageNum');

    var response = await http.get(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Article
    List<Article> listArticle = [];
    for (var d in data[0]) {
      if (d != null) {
        listArticle.add(Article.fromJson(d));
      }
    }

    _pageNum = data[1];
    return listArticle;
  }

  addArticle() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddArticlePage()),
    );
  }

  makeCards(AsyncSnapshot snapshot) {
    return ListView.builder(
        itemCount: snapshot.data!.length + 2,
        itemBuilder: (_, index) {
          if (index == 0) {
            // Intro
            return const Padding(
              padding: EdgeInsets.fromLTRB(20, 25, 20, 20),
              child: Text(
                'Across the world, enviromental issues become a growing problems, such as lack of water, loss of biodiversity, and climate change. So we in EcoFriend curated news from UN News and our users to raise awareness of environmental issues in every part of the world.',
                style: TextStyle(
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.center,
              ),
            );
          } else if (index == 1) {
            // Dropdown
            return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                'Region: ',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(width: 15),
              DropdownButton<String>(
                // Dropdown region
                underline: const SizedBox(),
                borderRadius: BorderRadius.circular(8.0),
                value: _thisRegion,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: _listRegion.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items.splitMapJoin(RegExp(r'%20'),
                          onMatch: (m) => ' ',
                          onNonMatch: (m) =>
                              m[0].toUpperCase() + m.substring(1)),
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  );
                }).toList(),
                hint: const Text('Filter by Region'),
                onChanged: (String? newValue) {
                  setState(() {
                    _firstTime = false;
                    _thisRegion = newValue!;
                    _thisPageNum = 1;
                    setState(() {});
                  });
                },
              )
            ]);
          } else if (index == 2) {
            // Paginator
            return Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  for (int i = 0; i < _pageNum; i++)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xffcfffcc)),
                          ),
                          onPressed: () {
                            _firstTime = false;
                            _thisPageNum = i + 1;
                            setState(() {});
                          },
                          child: Text(
                            '${i + 1}',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                ]);
          } else {
            // Cards
            index -= 2;
            return InkWell(
              child: Container(
                // Style container
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                    color: const Color(0xffcfffcc),
                    borderRadius: BorderRadius.circular(8.0),
                    //border:Border.all(width: 1.0, color: const Color(0xff198754)),
                    boxShadow: const [
                      BoxShadow(color: Color.fromARGB(167, 207, 255, 204), blurRadius: 10.0)
                    ]),
                child: Column(children: [
                  // Gambar article
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      imageUrl: "${snapshot.data![index].fields.image}",
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Text article
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: Text(
                          "${snapshot.data![index].fields.title}",
                          style: const TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                        child: Text(
                          "${snapshot.data![index].fields.date.year.toString().padLeft(4, '0')}-${snapshot.data![index].fields.date.month.toString().padLeft(2, '0')}-${snapshot.data![index].fields.date.day.toString().padLeft(2, '0')}",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Text(
                          "${snapshot.data![index].fields.region}",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                        child: Text(
                          "${snapshot.data![index].fields.description}",
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              onTap: () async {
                var url = Uri.parse("${snapshot.data![index].fields.link}");
                if (!await launchUrl(url)) {
                  throw 'Could not launch $url';
                }
              },
            );
          }
        });
  }
}
