import 'package:crudflutter/api_service.dart';
import 'package:crudflutter/cadastro_cliente.dart';
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
              child: Text('Não há clientes cadastrados!'),
            );
          }
          return ListView.builder(
              itemCount: clientes?.length ?? 0,
              itemBuilder: (context, index) {
                final cliente = clientes![index];
                return Card(
                  child: ListTile(
                      title: Text(cliente.nome!),
                      subtitle: Text(cliente.cpf!),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () async {
                          await apiService.deletaCliente(cliente);
                        },
                      )),
                );
              });
        },
      ),
    );
  }
}