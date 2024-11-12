import 'dart:convert';
import 'package:gs/models/eletropostos_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = "https://eletropostos.azurewebsites.net/api/eletroposto";

  Future<List<Eletroposto>> fetchEletropostos() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => Eletroposto.fromJson(item)).toList();
      } else {
        throw Exception('Falha ao carregar os dados dos eletropostos');
      }
    } catch (e) {
      throw Exception('Erro ao fazer a requisição: $e');
    }
  }
}
