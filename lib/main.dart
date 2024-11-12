import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gs/providers/etropostos_provider.dart';
import 'package:gs/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EletropostoProvider(),
      child: MaterialApp(
        title: 'Eletropostos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}