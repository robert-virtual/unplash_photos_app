import 'package:flutter/material.dart';
import 'package:flutter_linux_app1/helpers/my_search.dart';
import 'package:flutter_linux_app1/screens/search.dart';

class TaskPage extends StatefulWidget {
  TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List<String> historial = [];
  String? search = "";
  List<String> tareas = [];
  List<String> tareasCopy = [];
  final tarea = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tareas"),
        actions: [
          IconButton(
              onPressed: () async {
                search = await showSearch(
                    context: context,
                    delegate: MySearch(historial: historial, items: tareas));
                if (search != null && search!.length > 0) {
                  setState(() {
                    tareasCopy =
                        tareasCopy.where((e) => e.startsWith(search!)).toList();
                  });
                }
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: ListView.builder(
          itemCount: tareasCopy.length,
          itemBuilder: (context, i) {
            return Column(
              children: [
                ListTile(
                  title: Text(tareasCopy[i]),
                ),
                Divider()
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return modal();
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget modal() {
    return Container(
      margin: EdgeInsets.only(top: 25, right: 10),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close)),
              OutlinedButton(
                  onPressed: () {
                    if (tarea.text.length > 0) {
                      setState(() {
                        tareas.insert(0, tarea.text);
                        tareasCopy.insert(0, tarea.text);
                        tarea.clear();
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Guardar"))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLines: null,
              controller: tarea,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Escriba...",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
