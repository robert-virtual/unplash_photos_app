import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  var historial = ["No ha buscado nada"];

  @override
  List<Widget> buildActions(BuildContext context) {
    //actions

    return [IconButton(onPressed: () {}, icon: Icon(Icons.clear))];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leadin icon on le the left
    return IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // mostrar resultados
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // historial
    return ListView.builder(
        itemCount: historial.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: Icon(Icons.history),
            title: Text(historial[i]),
          );
        });
  }
}
