import 'package:crudflutter/dashboard_cliente.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//Classe Main recebendo "Cadastro" como parâmetro na Home.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DashBoardCliente(),
    );
  }
}
