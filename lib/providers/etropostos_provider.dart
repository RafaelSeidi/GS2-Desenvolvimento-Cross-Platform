import 'package:flutter/material.dart';
import 'package:gs/models/eletropostos_model.dart';
import 'package:gs/services/api_service.dart';

class EletropostoProvider with ChangeNotifier {
  List<Eletroposto> _eletropostos = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Eletroposto> get eletropostos => _eletropostos;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchEletropostos() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      List<Eletroposto> eletropostos = await ApiService().fetchEletropostos();
      _eletropostos = eletropostos;
    } catch (e) {
      _errorMessage = 'Erro ao carregar os dados: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
