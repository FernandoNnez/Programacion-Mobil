import 'package:flutter/material.dart';
import 'navegador.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navegación',
      home: Navegador(),
    );
  }
}
