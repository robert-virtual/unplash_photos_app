import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  final List<String> historial;
  DataSearch({required this.historial});
  @override
  List<Widget> buildActions(BuildContext context) {
    //actions

    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leadin icon on le the left
    return IconButton(
        onPressed: () {
          close(context, "");
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // mostrar resultados

    close(context, query);
    return Center(
      child: Text("Hola"),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // historial
    if (historial.length > 0) {
      return ListView.builder(
          itemCount: historial.length,
          itemBuilder: (context, i) {
            return ListTile(
              leading: Icon(Icons.history),
              title: Text(historial[i]),
            );
          });
    }
    return ListTile(
      title: Text("Sugerencias"),
    );
  }
}
