import 'package:flutter/material.dart';
import 'package:flutter_linux_app1/screens/home.dart';
import 'package:flutter_linux_app1/screens/photos.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'primer App',
      theme: Theme.of(context).copyWith(
          primaryColor: Colors.black,
          appBarTheme: Theme.of(context)
              .appBarTheme
              .copyWith(brightness: Brightness.dark)),
      home: Scaffold(
          body: IndexedStack(
            index: index,
            children: [HomePage(), PhotosPage()],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            onTap: (idx) {
              setState(() {
                index = idx;
              });
            },
            items: [
              BottomNavigationBarItem(label: "inicio", icon: Icon(Icons.home)),
              BottomNavigationBarItem(label: "Fotos", icon: Icon(Icons.photo))
            ],
          )),
    );
  }
}
