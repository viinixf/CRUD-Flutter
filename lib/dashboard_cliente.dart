import 'package:crudflutter/cadastro_cliente.dart';
import 'package:crudflutter/lista_de_clientes.dart';
import 'package:flutter/material.dart';

class DashBoardCliente extends StatelessWidget {
  const DashBoardCliente({super.key});

  ///Criação da página principal (Dashboard)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text(
          'Gerenciador de clientes',
          style: TextStyle(fontSize: 20),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),

            ///Ao pressionar o "Done", será encaminhado para "Cadastro do cliente"
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CadastroCliente()));
            },
          )
        ],
      ),

      ///Retornará no corpo do Dashboard a lista de cliente
      body: const ListaDeClientes(),
    );
  }
}
