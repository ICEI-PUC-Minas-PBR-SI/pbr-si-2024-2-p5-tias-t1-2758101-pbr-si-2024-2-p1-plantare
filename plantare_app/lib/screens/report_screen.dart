import 'package:flutter/material.dart';
import 'package:plantare_app/core/app_colors.dart';
import 'package:plantare_app/database/database_helper.dart'; // Certifique-se de que este import esteja correto
import '../main.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  late Future<List<Map<String, dynamic>>> _plantiosFuture;

  String userName = UserSession().getLoggedInUser() ?? '';

  @override
  void initState() {
    super.initState();
    _plantiosFuture = _firestoreService.getPlantiosComPeriodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF4A4A4A),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Relatório de Períodos de Plantio',
              style: TextStyle(
                fontFamily: 'Oswald',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _plantiosFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text(
                            'Erro ao carregar os dados: ${snapshot.error}'));
                  } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return Center(
                        child: Text(
                            'Nenhum dado encontrado para o usuário logado.'));
                  }

                  final plantios = snapshot.data!;
                  return ListView.builder(
                    itemCount: plantios.length,
                    itemBuilder: (context, index) {
                      final plantio = plantios[index];
                      final verduraDetails = plantio['verduraDetails'] ?? {};

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ExpansionTile(
                          leading: Icon(Icons.grass, color: Color(0xFF0F6D5F)),
                          title: Text(
                            plantio['nome'] ?? 'Sem nome',
                            style: TextStyle(
                              fontFamily: 'Oswald',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Período até a colheita: ${plantio['periodoEmDias'] ?? 'Ainda em andamento'} dias',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 14,
                            ),
                          ),
                          children: [
                            ListTile(
                              title: Text(
                                'Clima: ${verduraDetails['clima'] ?? 'Desconhecido'}',
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'Solo Ideal: ${verduraDetails['solo_ideal'] ?? 'Desconhecido'}',
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'Quantidade de Água: ${verduraDetails['quantidade_agua_ml'] ?? 'Desconhecida'}',
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'Época de Plantio Ideal: ${verduraDetails['época_plantio_ideal'] ?? 'Desconhecida'}',
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Container(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: Color(0xFF000000)),
                onPressed: () {
                  Navigator.pushNamed(context, '/home'); // Navegar para Home
                },
              ),
              IconButton(
                icon: Icon(Icons.people, color: Color(0xFF000000)),
                onPressed: () {
                  Navigator.pushNamed(context, '/community'); // Navegar para Comunidade
                },
              ),
              SizedBox(width: 40), // Espaço para o botão central
              IconButton(
                icon: Icon(Icons.analytics, color: Color(0xFF000000)),
                onPressed: () {
                  Navigator.pushNamed(context, '/report'); // Navegar para Métricas
                },
              ),
              IconButton(
                icon: Icon(Icons.person, color: Color(0xFF000000)),
                onPressed: () {
                  Navigator.pushNamed(context, '/settings'); // Navegar para Perfil
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 56.0,
        width: 56.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFF04BB86), Color(0xFF225149)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/planting'); // Navegar para Plantio
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
