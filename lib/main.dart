import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pic_puzzle_game/First_page.dart';

void main()
{
      runApp(MaterialApp(debugShowCheckedModeBanner: false,home: MyApp(),));

}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,home: FirstPage(),);
  }
}
