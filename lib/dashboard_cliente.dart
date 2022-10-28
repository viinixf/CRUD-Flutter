import 'package:crudflutter/cadastro_cliente.dart';
import 'package:crudflutter/lista_de_clientes.dart';
import 'package:flutter/material.dart';

/// Criação da classe Dashboard.
class DashBoardCliente extends StatelessWidget {
  const DashBoardCliente({super.key});

  @override
  Widget build(BuildContext context) {
    /// Widget Scaffold.
    return Scaffold(
      // Banner principal exibido na parte superior da tela.
      appBar: AppBar(
        // Centralização do tituloAppBar.
        centerTitle: true,
        // Cor do AppBar
        backgroundColor: Colors.green,
        title: const Text(
          // Texto que ocupará o AppBar.
          'Gerenciador de clientes',
          // Tamanho do AppBar.
          style: TextStyle(fontSize: 20),
        ),
        actions: <Widget>[
          // Icone do botão que ficará ao lado direito do título do AppBar.
          IconButton(
            icon: const Icon(
              // Icone "done".
              Icons.add,
              color: Colors.white,
            ),
            // OnPressed determinará o que será feito ao pressionar o Icone.
            onPressed: () {
              // Ao pressionar o Icone, será chamada a classe CadastroCliente através das rotas.
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CadastroCliente()));
            },
          )
        ],
      ),
      body: const ListaDeClientes(),
      // Manipula o corpo do Dashboard, neste body está sendo chamado o método ListaDeClientes no qual exibe os clientes cadastrados.
    );
  }
}
