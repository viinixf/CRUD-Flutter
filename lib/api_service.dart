import 'dart:convert';
import 'package:crudflutter/cliente.dart';
import 'package:crudflutter/utils/constantes.dart';
import 'package:http/http.dart' as http;

/// Classe reservada para os métodos HTTP
class ApiService {
  var urlRequest = Uri.parse('$apiUrl/clientes');

  ///Função assíncrona para listar os clientes (MÉTODO POST)
  Future<List<Cliente>> getListClientes() async {
    http.Response response = await http.get(urlRequest);

    ///Valida o statusCode
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Cliente> clientes =
          body.map((dynamic cliente) => Cliente.fromJson(cliente)).toList();
      return clientes;
    } else {
      throw "Falha ao carregar a lista";
    }
  }

  ///Função assíncrona para inserção dos clientes (MÉTODO INSERT)
  Future<Cliente> cadastrarCliente(Cliente cliente) async {
    http.Response response;

    try {
      response = await http.post(
        urlRequest,
        headers: {"Content-type": "application/json"},
        body: cliente.toJson(),
      );

      ///Condição que valida se a resposta do Status foi bem sucedida
      if (response.statusCode > 300 && response.statusCode <= 500) {
        throw Exception('Erro ao cadastrar o cliente');
      }
      return Cliente.fromJson(json.decode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  ///Função assíncrona para deletar os clientes (método DELETE)
  Future<http.Response> deletarCliente(int id) async {
    var urlRequest = Uri.parse('$apiUrl/clientes/$id');
    final http.Response response = await http.delete(
      urlRequest,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  /// Função assíncrona para atualizar a lista de clientes (método PUT)
  Future<Cliente> atualizarCliente(int id, Cliente cliente) async {
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
