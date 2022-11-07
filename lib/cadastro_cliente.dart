import 'package:crudflutter/api_service.dart';
import 'package:crudflutter/cliente.dart';
import 'package:crudflutter/dashboard_cliente.dart';
import 'package:flutter/material.dart';

class CadastroCliente extends StatelessWidget {
  /// GlobalKey utilizada para efetuar a validação dos campos de texto
  final formKey = GlobalKey<FormState>();
  final apiService = ApiService();

  /// Null Safety - depois do NullSafety todas as variáveis nunca poderam ser nulas
  final Cliente? cliente;

  CadastroCliente({this.cliente, super.key});

  @override
  Widget build(BuildContext context) {
    /// Criação do controlador para recuperar os valores de TextField
    final TextEditingController controladorNome =
        TextEditingController(text: cliente?.nome ?? '');
    final TextEditingController controladorIdade =
        TextEditingController(text: cliente?.idade.toString() ?? '');
    final TextEditingController controladorCpf =
        TextEditingController(text: cliente?.cpf ?? '');
    final TextEditingController controladorTelefone =
        TextEditingController(text: cliente?.telefone ?? '');

    /// Valida se o cliente possui ID ou é nulo para exibição do SnackBar
    final dadosClientes = cliente ?? Cliente();

    String appBarTitle;
    var idCadastroCliente = dadosClientes.id == null;
    if (idCadastroCliente) {
      appBarTitle = 'Cadastro do cliente';
    } else {
      appBarTitle = 'Atualização do cliente';
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(appBarTitle, style: const TextStyle(fontSize: 20)),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            /// Valida os campos de textos e retorna o SnackBar
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                try {
                  ///Valida se é um novo cadastro ou uma atualização
                  final clienteCadastrado = dadosClientes.id == null
                      ? await apiService.cadastrarCliente(dadosClientes)
                      : await apiService.atualizarCliente(
                          dadosClientes.id!, dadosClientes);
                  //Valida se o SnackBar retornará "cadastrado" ou "atualizado"
                  if (dadosClientes.id == null) {
                    final snackBar = SnackBar(
                        duration: const Duration(seconds: 2),
                        content: Text(
                          '${clienteCadastrado.nome} foi cadastrado com sucesso!',
                          style: const TextStyle(fontSize: 17),
                        ));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const DashBoardCliente()),
                      (route) => false,
                    );
                  } else {
                    final snackBar = SnackBar(
                        duration: const Duration(seconds: 2),
                        content: Text(
                          '${clienteCadastrado.nome} foi atualizado com sucesso!',
                          style: const TextStyle(fontSize: 17),
                        ));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(

                          ///Retorna para a tela inicial
                          builder: (context) => const DashBoardCliente()),
                      (route) => false,
                    );
                  }
                } catch (e) {
                  const snackBarErro =
                      SnackBar(content: Text("Erro ao cadastrar!"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBarErro);
                }
              }
            },
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(12.0),
                ),

                ///Campo de texto que recebe o nome e valida se está correto
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Nome:', labelStyle: TextStyle(fontSize: 17)),
                  style: const TextStyle(fontSize: 22),
                  controller: controladorNome,
                  onSaved: (newValue) {
                    dadosClientes.nome = newValue;
                  },
                  validator: (nome) {
                    if (nome == null || nome.isEmpty) {
                      return "O nome deve ser preenchido!";
                    }
                    return null;
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                ),

                ///Campo de texto que recebe a idade e valida se está correta
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Idade:', labelStyle: TextStyle(fontSize: 17)),
                  style: const TextStyle(fontSize: 22),
                  keyboardType: TextInputType.number,
                  controller: controladorIdade,
                  onSaved: (newValue) {
                    dadosClientes.idade = int.tryParse(newValue!);
                  },
                  maxLength: 3,
                  validator: (idade) {
                    if (idade == null || idade.isEmpty) {
                      return "A idade deve ser preenchida!";
                    }
                    return null;
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                ),

                ///Campo de texto que recebe o CPF e valida se está correto
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'CPF:', labelStyle: TextStyle(fontSize: 17)),
                  style: const TextStyle(fontSize: 22),
                  controller: controladorCpf,
                  onSaved: (newValue) {
                    dadosClientes.cpf = newValue;
                  },
                  maxLength: 14,
                  validator: (cpf) {
                    if (cpf == null || cpf.isEmpty) {
                      return "O CPF deve ser preenchido corretamente!";
                    }
                    return null;
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                ),

                ///Campo de texto que recebe o telefone e valida se está correto
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Telefone:',
                      labelStyle: TextStyle(fontSize: 17)),
                  style: const TextStyle(fontSize: 22),
                  controller: controladorTelefone,
                  onSaved: (newValue) {
                    dadosClientes.telefone = newValue;
                  },
                  maxLength: 15,
                  validator: (telefone) {
                    if (telefone == null || telefone.isEmpty) {
                      return "O telefone deve ser preenchido!";
                    }
                    return null;
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
