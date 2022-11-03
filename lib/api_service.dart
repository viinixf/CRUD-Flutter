import 'dart:convert';
import 'package:crudflutter/cliente.dart';
import 'package:crudflutter/utils/constantes.dart';
import 'package:http/http.dart' as http;

/// Classe que será utilizada para colocar os métodos HTTP.
class ApiService {
  ///Declaração da variável localhost, no qual é armazenado o IP da máquina 192.168.1.181
  var urlRequest = Uri.parse('$apiUrl/clientes');

  ///Criação da função assíncrona para listar os clientes (MÉTODO POST)
  Future<List<Cliente>> getClientes() async {
    ///Criando objeto "res" do tipo Resposta(response), e atribuindo ao Http.get
    http.Response res = await http.get(urlRequest);

    ///Se o status da busca ser = 200, irá retornar a Lista de clientes cadastrados, caso contrário, retornará erro
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Cliente> clientes =
          body.map((dynamic item) => Cliente.fromJson(item)).toList();
      return clientes;
    } else {
      throw "Failed to load cases list";
    }
  }

  ///Criação da função assíncrona para inserção dos clientes (MÉTODO INSERT)
  Future<Cliente> cadastraCliente(Cliente cliente) async {
    ///Instanciando response (criando objeto response)
    http.Response response;

    ///Criando tratamento
    try {
      response = await http.post(
        urlRequest,
        headers: {"Content-type": "application/json"},
        body: cliente.toJson(),
      );

      ///Condição para validar se a resposta do Status foi bem sucedida
      if (response.statusCode > 300 && response.statusCode <= 500) {
        throw Exception('Erro ao cadastrar o cliente');
      }
      return Cliente.fromJson(json.decode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  ///Criação da função assíncrona para deletar os clientes (método DELETE)
  Future<http.Response> deletaCliente(int id) async {
    var urlRequest = Uri.parse('$apiUrl/clientes/$id');
    final http.Response response = await http.delete(
      urlRequest,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    ///Retornando response pois a Future exige um tipo de retorno
    return response;
  }

  ///Criação da função assíncrona para atualizar a lista de clientes (método PUT)
  Future<Cliente> atualizaCliente(int id, Cliente cliente) async {
    var urlRequest = Uri.parse('$apiUrl/clientes/$id');
    final http.Response response = await http.put(urlRequest,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: cliente.toJson());
    if (response.statusCode == 200) {
      return Cliente.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao atualizar');
    }
  }
}
