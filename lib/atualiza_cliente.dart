import 'package:crudflutter/dashboard_cliente.dart';
import 'package:flutter/material.dart';

class AtualizaCliente extends StatelessWidget {
  const AtualizaCliente({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          "Atualização do cliente",
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () async {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const DashBoardCliente()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(12.0),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Novo nome: ',
                      labelStyle: TextStyle(fontSize: 17)),
                  style: const TextStyle(fontSize: 22),
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Nova idade: ',
                      labelStyle: TextStyle(fontSize: 17)),
                  style: const TextStyle(fontSize: 22),
                  maxLength: 3,
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Novo CPF: ',
                      labelStyle: TextStyle(fontSize: 17)),
                  style: const TextStyle(fontSize: 22),
                  maxLength: 14,
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Novo telefone: ',
                      labelStyle: TextStyle(fontSize: 17)),
                  style: const TextStyle(fontSize: 22),
                  maxLength: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
