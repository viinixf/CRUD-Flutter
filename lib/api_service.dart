import 'dart:convert';
import 'package:crudflutter/cliente.dart';
import 'package:crudflutter/utils/constantes.dart';
import 'package:http/http.dart' as http;

/// Classe que será utilizada para colocar os métodos HTTP.
class ApiService {
  //Declaração da variável localhost, no qual é armazenado o IP da máquina 192.168.1.181
  var urlRquest = Uri.parse('$apiUrl/clientes');
  Future<List<Cliente>> getClientes() async {
    http.Response res = await http.get(urlRquest);

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
        urlRquest,
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

  Future<Cliente> deletaCliente(Cliente cliente) async {
    http.Response response;
    try {
      response = await http.delete(
        urlRquest,
        headers: {"Content-type": "application/json"},
        body: cliente.toJson(),
      );

      if (response.statusCode > 300 && response.statusCode <= 500) {
        throw Exception('Erro ao deletar o cliente');
      }
      return Cliente.fromJson(json.decode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }
}


//   Future<Cliente> deletaCliente(Cliente cliente) async {
//     http.Response response;
//     response = await http.delete(
//       urlRquest,
//       headers: {"Content-type": "application/json"},
//       body: cliente.toJson(),
//     );
//     if (response.statusCode == 200) {
//       return Cliente.fromJson(jsonDecode(response.body));
//     }
//     throw Exception('Falha ao deletar');
//   }
// }
