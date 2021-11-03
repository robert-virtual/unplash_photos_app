import 'package:flutter/material.dart';

class MySearch extends SearchDelegate<String> {
  final List<String> historial;
  final List<String> items;
  MySearch({required this.historial, required this.items});
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
    List<String> res = items.where((e) => e.startsWith(query)).toList();
    return ListView.builder(
        itemCount: res.length,
        itemBuilder: (context, i) {
          return Column(
            children: [
              ListTile(
                title: Text(res[i]),
                onTap: () {
                  close(context, res[i]);
                },
              )
            ],
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> res = query.isNotEmpty
        ? items.where((e) => e.startsWith(query)).toList()
        : [];

    // historial
    if (res.length > 0) {
      return ListView.builder(
          itemCount: res.length,
          itemBuilder: (context, i) {
            return ListTile(
              leading: Icon(Icons.star),
              title: Text(res[i]),
            );
          });
    }
    return ListTile(
      title: Text("Sugerencias"),
    );
  }
}
