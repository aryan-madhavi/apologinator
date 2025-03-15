import 'package:apologinator/pages/home_page.dart';
import 'package:apologinator/themes/theme_data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Apologinator',
      theme: appTheme,
      initialRoute: '/home',
      routes: {
        '/home' : (context) => HomePage(),
        //'/allMsgs' : (context) => MyHomePage(),
      },
    );
  }
}
