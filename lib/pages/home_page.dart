import 'package:flutter/material.dart';
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
    Future.delayed(Duration.zero, () {
      Provider.of<EletropostoProvider>(context, listen: false)
          .fetchEletropostos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eletropostos'),
      ),
      body: Consumer<EletropostoProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.errorMessage.isNotEmpty) {
            return Center(child: Text('Erro: ${provider.errorMessage}'));
          } else if (provider.eletropostos.isEmpty) {
            return const Center(child: Text('Nenhum eletroposto encontrado.'));
          } else {
            final eletropostos = provider.eletropostos;
            return ListView.builder(
              itemCount: eletropostos.length,
              itemBuilder: (context, index) {
                final eletroposto = eletropostos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      eletroposto.nome,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(eletroposto.informacoes),
                        const SizedBox(height: 4),
                        Text('Endereço: ${eletroposto.endereco}'),
                        const SizedBox(height: 4),
                        Text('Telefone: ${eletroposto.telefone}'),
                        const SizedBox(height: 4),
                        Text('Conectores: ${eletroposto.conectores.join(", ")}'),
                      ],
                    ),
                    trailing: const Icon(Icons.ev_station),
                    onTap: () {

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
