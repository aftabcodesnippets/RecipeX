import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/splashscreen.dart';
import 'package:recipe/themeprovider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Themeprovider(),
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: context.watch<Themeprovider>().dark
          ? ThemeMode.dark
          : ThemeMode.light,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(),
      home: Splashscreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
