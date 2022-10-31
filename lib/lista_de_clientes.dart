import 'package:crudflutter/api_service.dart';
import 'package:crudflutter/atualiza_cliente.dart';
import 'package:flutter/material.dart';
import 'cliente.dart';

class ListaDeClientes extends StatefulWidget {
  const ListaDeClientes({super.key});

  @override
  State<ListaDeClientes> createState() => _ListaDeClientes();
}

class _ListaDeClientes extends State<ListaDeClientes> {
  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
    return RefreshIndicator(
      onRefresh: () async {},
      child: FutureBuilder<List<Cliente>>(
        future: apiService.getClientes(),
        builder: (context, snapshot) {
          final clientes = snapshot.data;
          if (clientes != null && clientes.isEmpty) {
            return const Center(
              child: Text(
                'Não há clientes cadastrados!',
                style: TextStyle(fontSize: 19),
              ),
            );
          }
          return ListView.builder(
              itemCount: clientes?.length ?? 0,
              itemBuilder: (context, index) {
                final cliente = clientes![index];
                return ListTile(
                  title: Text(cliente.nome!),
                  subtitle: Text(cliente.cpf!),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () async {
                      apiService.deletaCliente(cliente.id!);
                      final snackBar = SnackBar(
                          duration: const Duration(seconds: 2),
                          content: Text(
                            '${cliente.nome} foi removido com sucesso!',
                            style: const TextStyle(fontSize: 17),
                          ));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      setState(() {});
                    },
                  ),
                  leading: IconButton(
                    padding: const EdgeInsets.all(10.0),
                    iconSize: 24,
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AtualizaCliente()));
                      setState(() {});
                    },
                  ),
                );
              });
        },
      ),
    );
  }
}
