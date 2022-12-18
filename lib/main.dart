import 'dart:io';

import 'package:flutter/material.dart';
import 'package:random_episode/ui/search_page.dart';

import 'ui/home_page.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
        '/search': (context) => const SearchPage(
              title: 'search',
              searchValue: '',
            ),
      },
    );
  }
}
