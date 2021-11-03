import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_linux_app1/models/photo.dart';
import 'package:flutter_linux_app1/screens/search.dart';
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
  late Future<List<Photo>> data;
  List<String> historial = [];
  String accessKey = "PXsNeNw0MIPqNbcv0c5Za0CZx9vorevotl7C60-EATk";
  int? _value = 0;
  String? search = "";
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
    data = fetchPhotos();
  }

  void buscar() {
    _value = null;
    query["query"] = search!;
    data = fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Unplash Fotos"),
        actions: [
          IconButton(
              onPressed: () async {
                search = await showSearch(
                    context: context,
                    delegate: DataSearch(historial: historial));
                setState(() {
                  if (search != "" && search != null) {
                    historial.insert(0, search!);
                    buscar();
                  }
                });
              },
              icon: Icon(Icons.search))
        ],
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
                          print("onSelected");
                          setState(() {
                            _value = selected ? i : null;
                            if (_value != null) {
                              query["query"] = cats[_value ?? 0];
                              refreshdata();
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<List<Photo>>(
                future: data,
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
                    return Center(child: Text(snap.error.toString()));
                  }
                  return Center(child: CircularProgressIndicator());
                })
          ],
        ),
      ),
    );
  }

  Future<List<Photo>> fetchPhotos() async {
    try {
      final res = await http.get(Uri.https(authority, unencodedPath, query),
          headers: {HttpHeaders.authorizationHeader: 'Client-ID $accessKey'});
      if (res.statusCode == 200) {
        List<dynamic> photos = jsonDecode(res.body)["results"];

        return List.generate(photos.length, (i) => Photo.fromJson(photos[i]));
      }
      // throw Exception("No se pudo cargar Las photos");
      return Future.error(
          "Hubo un error al cargar los datos. Vuelva a intentar");
    } on SocketException catch (_) {
      return Future.error("No hay Coneccion a Internet");
    }
  }
}
