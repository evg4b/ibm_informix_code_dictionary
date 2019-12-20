import 'package:flutter/material.dart';
import 'package:ibm_informix_code_dictionary/dictionary_home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IBM Informix сode dictionary',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: DictionaryHomePage(title: 'IBM Informix сode dictionary'),
    );
  }
}
