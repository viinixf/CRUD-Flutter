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
    /// Criação objeto do tipo ApiService
    ApiService apiService = ApiService();

    /// Retornando RefreshIndicator
    return RefreshIndicator(
      onRefresh: () async {},
      child: FutureBuilder<List<Cliente>>(
        ///Future que chama o método getClientes da ApiService
        future: apiService.mostraClientes(),
        builder: (context, snapshot) {
          ///Final: atribuição única para váriaveis
          final clientesCadastradosPaginaInicial = snapshot.data;

          ///Condição que valida se há clientes cadastrados para serem exibidos na página inicial
          if (clientesCadastradosPaginaInicial != null &&
              clientesCadastradosPaginaInicial.isEmpty) {
            return const Center(
              child: Text(
                'Não há clientes cadastrados!',
                style: TextStyle(fontSize: 19),
              ),
            );
          }

          ///Retorna uma lista com os dados de nome e CPF do cliente
          return ListView.builder(
              itemCount: clientesCadastradosPaginaInicial?.length ?? 0,
              itemBuilder: (context, index) {
                final dadosClientesCadastrados =
                    clientesCadastradosPaginaInicial![index];

                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => DetalhesClientes(
                                  cliente: dadosClientesCadastrados,
                                ))));
                  },
                  title: Text(dadosClientesCadastrados.nome!),
                  subtitle: Text(dadosClientesCadastrados.cpf!),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () async {
                      ///Chamando o método deleta cliente quando o IconButton "Delete" ser pressionado
                      apiService.deletaCliente(dadosClientesCadastrados.id!);

                      ///Após a remoção, retorna a mensagem de " (nome) + " removido com sucesso "!"
                      final snackBar = SnackBar(
                          duration: const Duration(seconds: 2),
                          content: Text(
                            '${dadosClientesCadastrados.nome} foi removido com sucesso!',
                            style: const TextStyle(fontSize: 17),
                          ));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      /// Método exclusivo ao Widgets do tipo Stateful, serve para reconstruir o Widget, com os novos valores
                      /// É implementado pois o Widget precisa ser reconstruir após a remoção de um cliente
                      setState(() {});
                    },
                  ),

                  ///Icone de editar
                  leading: IconButton(
                    padding: const EdgeInsets.all(10.0),
                    iconSize: 24,
                    icon: const Icon(Icons.edit),

                    ///Quando pressionado, será redirecionado para a página de CadastroClientes
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          /// dadosClientesCadastrados são passados neste parâmetro para retornar as informações ao pressionar editar
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
