import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class Cat {
  String name;
  List<String> items;
  Cat({required this.name, required this.items});
}

class _HomePageState extends State<HomePage> {
  int _value = 0;
  List<Cat> data = [
    Cat(name: "Aves", items: List.generate(20, (i) => "Ave # $i")),
    Cat(name: "Insectos", items: List.generate(20, (i) => "Insecto # $i")),
    Cat(name: "Mamiferos", items: List.generate(20, (i) => "Mamifero # $i")),
    Cat(name: "Peces", items: List.generate(20, (i) => "Pez # $i")),
    Cat(name: "Bacterias", items: List.generate(20, (i) => "Bacteria # $i")),
    Cat(name: "Plantas", items: List.generate(20, (i) => "Planta # $i"))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
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
                      data.length,
                      (i) => ChoiceChip(
                        label: Text(data[i].name),
                        selected: _value == i,
                        onSelected: (selected) {
                          setState(() {
                            _value = selected ? i : 0;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data[_value].items.length,
              itemBuilder: (context, i) {
                return ListTile(
                  leading: Icon(Icons.star),
                  title: Text(data[_value].items[i]),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
