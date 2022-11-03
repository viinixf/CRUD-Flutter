import 'package:crudflutter/api_service.dart';
import 'package:crudflutter/cliente.dart';
import 'package:crudflutter/dashboard_cliente.dart';
import 'package:flutter/material.dart';

///Classe Cadastro cliente.
class CadastroCliente extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final apiService = ApiService();

  final Cliente? cliente;

  CadastroCliente({this.cliente, super.key});

  ///Criação do Widget.
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

    final cadastroCliente = cliente ?? Cliente();
    String appBarTitle;
    var idCadastroCliente = cadastroCliente.id == null;
    if (idCadastroCliente) {
      appBarTitle = 'Cadastro do cliente';
    } else {
      appBarTitle = 'Atualização do cliente';
    }

    ///Widget Scaffold.
    return Scaffold(
      //Barra superior do aplicativo.
      appBar: AppBar(
        //Propriedade que centraliza o texto do AppBar.
        centerTitle: true,
        //Título do App bar.
        title: Text(appBarTitle, style: const TextStyle(fontSize: 20)),
        //Define a cor do AppBar.
        backgroundColor: Colors.green,
        actions: [
          //Icone "Done" que ficará no canto direito da tela na barra superior.
          IconButton(
            // Ao pressionar o "Done", fará a validação dos campos e exibirá um SnackBar caso cliente seja inserido.
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                try {
                  final clienteCadastrado = cadastroCliente.id == null
                      ? await apiService.cadastraCliente(cadastroCliente)
                      : await apiService.atualizaCliente(
                          cadastroCliente.id!, cadastroCliente);
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
                } catch (e) {
                  // Caso as informações sejam inválidas, retornará a mensagem de "Erro ao cadastrar".
                  final snackBar = SnackBar(
                      duration: const Duration(seconds: 2),
                      content: Text(
                        "Erro ao cadastrar!\n${e.toString()}",
                        style: const TextStyle(fontSize: 17),
                      ));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }
            },
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      //Contém o ScrollView no qual habilitará scrollar a interface e a distância entre o AppBar e o TextField.
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
                //TextField que conterá o nome junto com a validação.
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Nome:', labelStyle: TextStyle(fontSize: 17)),
                  style: const TextStyle(fontSize: 22),
                  controller: controladorNome,
                  onSaved: (newValue) {
                    cadastroCliente.nome = newValue;
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
                //TextField que conterá a idade junto com a validação.
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Idade:', labelStyle: TextStyle(fontSize: 17)),
                  style: const TextStyle(fontSize: 22),
                  controller: controladorIdade,
                  onSaved: (newValue) {
                    cadastroCliente.idade = int.tryParse(newValue!);
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
                //TextField que conterá o CPF junto com a validação.
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'CPF:', labelStyle: TextStyle(fontSize: 17)),
                  style: const TextStyle(fontSize: 22),
                  controller: controladorCpf,
                  onSaved: (newValue) {
                    cadastroCliente.cpf = newValue;
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
                //TextField que conterá o telefone junto com a validação.
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Telefone:',
                      labelStyle: TextStyle(fontSize: 17)),
                  style: const TextStyle(fontSize: 22),
                  controller: controladorTelefone,
                  onSaved: (newValue) {
                    cadastroCliente.telefone = newValue;
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
