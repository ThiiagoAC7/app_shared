import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String theme = "Light";
  var themeData = ThemeData.light();

  void initState() {
    super.initState();
    loadTheme();
  }

  loadTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      theme = pref.getString("theme") ?? "Light";
      themeData = theme == "Dark" ? ThemeData.dark() : ThemeData.light();
    });
  }

  setTheme(_theme) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      theme = _theme;
      themeData = theme == "Dark" ? ThemeData.dark() : ThemeData.light();
      pref.setString("theme", theme);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Shared"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                setTheme("Light");
              },
              child: const Text("Light"),
            ),
            ElevatedButton(
              onPressed: () {
                setTheme("Dark");
              },
              child: const Text("Dark"),
            )
          ],
        ),
      ),
    );
  }
}
