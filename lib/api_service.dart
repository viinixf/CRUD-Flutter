import 'dart:convert';
import 'package:crudflutter/cliente.dart';
import 'package:crudflutter/utils/constantes.dart';
import 'package:http/http.dart' as http;

/// Classe que será utilizada para colocar os métodos HTTP.
class ApiService {
  //Declaração da variável localhost, no qual é armazenado o IP da máquina 192.168.1.181
  var urlRequest = Uri.parse('$apiUrl/clientes');
  Future<List<Cliente>> getClientes() async {
    http.Response res = await http.get(urlRequest);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Cliente> clientes =
          body.map((dynamic item) => Cliente.fromJson(item)).toList();
      return clientes;
    } else {
      throw "Failed to load cases list";
    }
  }

  Future<Cliente> cadastraCliente(Cliente cliente) async {
    http.Response response;
    try {
      response = await http.post(
        urlRequest,
        headers: {"Content-type": "application/json"},
        body: cliente.toJson(),
      );
      if (response.statusCode > 300 && response.statusCode <= 500) {
        throw Exception('Erro ao cadastrar o cliente');
      }
      return Cliente.fromJson(json.decode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> deletaCliente(int id) async {
    var urlRequest = Uri.parse('$apiUrl/clientes/$id');
    final http.Response response = await http.delete(
      urlRequest,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }
}
