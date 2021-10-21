import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';

class PhotosPage extends StatefulWidget {
  PhotosPage({Key? key}) : super(key: key);

  @override
  _PhotosPageState createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  // https://api.unsplash.com/search/photos?query=canada
  Map<String, String> query = {"query": "aves"};
  //authority // unencodedpath // query
  String authority = "api.unsplash.com";
  String unencodedPath = "search/photos";
  late Future<List<Photo>> futurePhotos;
  String accessKey = "PXsNeNw0MIPqNbcv0c5Za0CZx9vorevotl7C60-EATk";
  int _value = 0;
  List<String> cats = [
    "Aves",
    "Insectos",
    "Mamiferos",
    "Peces",
    "Bacterias",
    "Plantas"
  ];

  @override
  void initState() {
    super.initState();
    refreshdata();
  }

  void refreshdata() {
    futurePhotos = fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Unplash Fotos "),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Wrap(
                    spacing: 4.0,
                    children: List.generate(
                      cats.length,
                      (i) => ChoiceChip(
                        label: Text(cats[i]),
                        selected: _value == i,
                        onSelected: (selected) {
                          setState(() {
                            _value = selected ? i : 0;
                            query["query"] = cats[_value];
                            refreshdata();
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<List<Photo>>(
                future: futurePhotos,
                builder: (context, snap) {
                  if (snap.hasData) {
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snap.data!.length,
                        itemBuilder: (context, i) {
                          return Column(
                            children: [
                              FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: snap.data![i].url),
                              ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    snap.data![i].userImg,
                                    width: 40,
                                  ),
                                ),
                                title: Text(snap.data![i].description ??
                                    "Foto de ${snap.data![i].author}"),
                                subtitle: Text(snap.data![i].author),
                              ),
                              SizedBox(
                                height: 5,
                              )
                            ],
                          );
                        });
                  }
                  if (snap.hasError) {
                    return Text("Ups ha habido un error al cargar los datos");
                  }
                  return Center(child: CircularProgressIndicator());
                })
          ],
        ),
      ),
    );
  }

  Future<List<Photo>> fetchPhotos() async {
    final res = await http.get(Uri.https(authority, unencodedPath, query),
        headers: {HttpHeaders.authorizationHeader: 'Client-ID $accessKey'});
    if (res.statusCode == 200) {
      List<dynamic> photos = jsonDecode(res.body)["results"];

      return List.generate(photos.length, (i) => Photo.fromJson(photos[i]));
    }
    throw Exception("No se pudo cargar Las photos");
  }
}

class Photo {
  final String id;
  final int likes;
  final String? description;
  final String url;
  final String author;
  final String userImg;

  Photo(
      {required this.id,
      required this.author,
      this.description,
      required this.likes,
      required this.url,
      required this.userImg});
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
        id: json['id'],
        author: json['user']['name'],
        description: json['alt_description'],
        likes: json['likes'],
        url: json['urls']['regular'],
        userImg: json['user']['profile_image']['medium']);
  }
}
