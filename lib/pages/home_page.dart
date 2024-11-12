import 'package:flutter/material.dart';
import 'package:gs/models/eletropostos_model.dart';
import 'package:provider/provider.dart';
import 'package:gs/providers/etropostos_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Chama o método fetchEletropostos quando a página for carregada
    Future.delayed(Duration.zero, () {
      Provider.of<EletropostoProvider>(context, listen: false)
          .fetchEletropostos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eletropostos'),
      ),
      body: Consumer<EletropostoProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            // Exibe o CircularProgressIndicator enquanto está carregando
            return Center(child: CircularProgressIndicator());
          } else if (provider.errorMessage.isNotEmpty) {
            // Exibe uma mensagem de erro, se houver
            return Center(child: Text('Erro: ${provider.errorMessage}'));
          } else if (provider.eletropostos.isEmpty) {
            // Exibe uma mensagem caso não haja eletropostos
            return Center(child: Text('Nenhum eletroposto encontrado.'));
          } else {
            final eletropostos = provider.eletropostos;
            return ListView.builder(
              itemCount: eletropostos.length,
              itemBuilder: (context, index) {
                final eletroposto = eletropostos[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      eletroposto.nome,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Informações adicionais
                        Text(eletroposto.informacoes),
                        SizedBox(height: 4),
                        Text('Endereço: ${eletroposto.endereco}'),
                        SizedBox(height: 4),
                        Text('Telefone: ${eletroposto.telefone}'),
                        SizedBox(height: 4),
                        Text('Conectores: ${eletroposto.conectores.join(", ")}'),
                      ],
                    ),
                    trailing: Icon(Icons.ev_station),
                    onTap: () {
                      // Ação ao clicar no eletroposto (poderia ser para abrir mais detalhes)
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
