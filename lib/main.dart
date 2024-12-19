import 'package:flutter/material.dart';
import 'package:movie_test/providers/movie_fetch_provider.dart';
import 'package:movie_test/screens/filter_list_page.dart';
import 'package:movie_test/screens/movie_list_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PostProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter HTTP and Provider Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MovieFilterList(),
    );
  }
}
