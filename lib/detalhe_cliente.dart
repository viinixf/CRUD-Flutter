import 'package:crudflutter/cliente.dart';
import 'package:crudflutter/dashboard_cliente.dart';
import 'package:flutter/material.dart';

class DetalhesClientes extends StatefulWidget {
  final Cliente cliente;
  const DetalhesClientes({super.key, required this.cliente});

  @override
  State<DetalhesClientes> createState() => _DetalheClienteState();
}

///Retorna ao menu após selecionar o BackButton
class _DetalheClienteState extends State<DetalhesClientes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop(const DashBoardCliente());
          },
        ),
        centerTitle: true,
        title: const Text("Detalhes do cliente"),
        backgroundColor: Colors.green,
      ),

      ///Define a imagem no CircleAvatar
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      "https://www.woolha.com/media/2020/03/flutter-circleavatar-minradius-maxradius.jpg"),
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                ),
                TextField(
                  controller: TextEditingController(text: widget.cliente.nome),
                  enabled: false,
                  decoration: const InputDecoration(
                      labelText: 'Nome:', labelStyle: TextStyle(fontSize: 17)),
                  style: const TextStyle(fontSize: 22),
                ),
                TextField(
                  controller:
                      TextEditingController(text: '${widget.cliente.idade}'),
                  enabled: false,
                  decoration: const InputDecoration(
                      labelText: 'Idade:', labelStyle: TextStyle(fontSize: 17)),
                  style: const TextStyle(fontSize: 22),
                ),
                TextField(
                  controller:
                      TextEditingController(text: '${widget.cliente.cpf}'),
                  enabled: false,
                  decoration: const InputDecoration(
                      labelText: 'CPF:', labelStyle: TextStyle(fontSize: 17)),
                  style: const TextStyle(fontSize: 22),
                ),
                TextField(
                  controller:
                      TextEditingController(text: '${widget.cliente.telefone}'),
                  enabled: false,
                  decoration: const InputDecoration(
                      labelText: 'Telefone:',
                      labelStyle: TextStyle(fontSize: 17)),
                  style: const TextStyle(fontSize: 22),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
