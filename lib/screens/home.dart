import 'package:flutter/material.dart';
import 'package:flutter_linux_app1/models/cat.dart';
import 'package:flutter_linux_app1/screens/search.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _value = 0;

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
