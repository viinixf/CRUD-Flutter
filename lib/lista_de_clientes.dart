import 'package:crudflutter/api_service.dart';
import 'package:crudflutter/cadastro_cliente.dart';
import 'package:flutter/material.dart';
import 'cliente.dart';
import 'detalhe_cliente.dart';

class ListaDeClientes extends StatefulWidget {
  const ListaDeClientes({super.key});

  @override
  State<ListaDeClientes> createState() => _ListaDeClientes();
}

class _ListaDeClientes extends State<ListaDeClientes> {
  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();

    ///Define a validação da lista
    return RefreshIndicator(
      onRefresh: () async {},
      child: FutureBuilder<List<Cliente>>(
        future: apiService.getListClientes(),
        builder: (context, snapshot) {
          final clientesCadastradosPaginaInicial = snapshot.data;
          if (clientesCadastradosPaginaInicial != null &&
              clientesCadastradosPaginaInicial.isEmpty) {
            return const Center(
              child: Text(
                'Não há clientes cadastrados!',
                style: TextStyle(fontSize: 19),
              ),
            );
          }

          ///Retorna a lista de clientes cadastrados
          return ListView.builder(
              itemCount: clientesCadastradosPaginaInicial?.length ?? 0,
              itemBuilder: (context, index) {
                final dadosClientesCadastrados =
                    clientesCadastradosPaginaInicial![index];

                ///Ao pressionar, redireciona para os Detalhes do cliente selecionado
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => DetalhesClientes(
                                  cliente: dadosClientesCadastrados,
                                ))));
                  },

                  ///Chama o método deleta cliente ao selecionar o Icon Button (Lixeira)
                  title: Text(dadosClientesCadastrados.nome!),
                  subtitle: Text(dadosClientesCadastrados.cpf!),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () async {
                      apiService.deletarCliente(dadosClientesCadastrados.id!);

                      ///Retorna o SnackBar informando que cliente foi removido
                      final snackBar = SnackBar(
                          duration: const Duration(seconds: 2),
                          content: Text(
                            '${dadosClientesCadastrados.nome} foi removido com sucesso!',
                            style: const TextStyle(fontSize: 17),
                          ));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      ///Reconstrói a página
                      setState(() {});
                    },
                  ),

                  ///Redireciona para a página de cadastro ao pressioanr o Icon Edit
                  leading: IconButton(
                    padding: const EdgeInsets.all(10.0),
                    iconSize: 24,
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CadastroCliente(
                            cliente: dadosClientesCadastrados,
                          ),
                        ),
                      );

                      ///Reconstrói a página
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
