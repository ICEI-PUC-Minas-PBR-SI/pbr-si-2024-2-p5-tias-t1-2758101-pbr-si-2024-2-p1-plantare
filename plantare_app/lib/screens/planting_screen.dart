import 'package:flutter/material.dart';
import '../core/app_text_styles.dart'; // Certifique-se de que o estilo de fonte de títulos esteja aqui
import '../core/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plantare_app/database/database_helper.dart';

class PlantingScreen extends StatefulWidget {
  @override
  _PlantingScreenState createState() => _PlantingScreenState();
}

class _PlantingScreenState extends State<PlantingScreen> {
  List<String> verduras = [];
  String? selectedVerdura; // Para armazenar a verdura selecionada

  final FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    fetchVerduras(); // Chama o método para buscar as verduras
  }

  void fetchVerduras() async {
    List<String> fetchedVerduras = await firestoreService.getVerduras();
    setState(() {
      verduras = fetchedVerduras; // Atualiza o estado com as verduras obtidas
    });
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
            // Seção de botão de voltar com fundo circular e título abaixo da seta
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF4A4A4A), // Fundo cinza escuro do círculo
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white), // Seta branca
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Sua plantação',
                  style: AppTextStyles.title.copyWith( // Fonte Oswald para título
                    fontFamily: 'Oswald',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Instruções com imagem "planting_bag"
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Preencha as informações abaixo para acompanhar sua nova plantação',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/images/planting_bag.png',
                    height: 40,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Campo para Nome da Semente/Planta com fundo preto e texto branco
            DropdownButtonFormField<String>(
              value: selectedVerdura,
              onChanged: (String? newValue) {
                setState(() {
                  selectedVerdura = newValue; // Atualiza a verdura selecionada
                });
              },
              items: verduras.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      color: Colors.white,
                    ),
                  ),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Selecione uma verdura',
                labelStyle: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                fillColor: Color(0xFF180F0F),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Dica: Escolha uma verdura para plantar',
                hintStyle: TextStyle(
                  fontFamily: 'Manrope',
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
              dropdownColor: Color(0xFF180F0F),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),

            // Campo de Data com entrada numérica e ícone de calendário
            TextField(
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                labelText: 'Insira a data do seu plantio',
                labelStyle: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                suffixIcon: Icon(
                  Icons.calendar_today,
                  color: Colors.grey,
                ),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Dropdown para Tipo de Solo com fundo preto e texto branco
            DropdownButtonFormField<String>(
              items: [
                'Latossolos',
                'Argissolos',
                'Neossolos',
                'Cambissolos',
                'Planossolos',
                'Gleissolos',
                'Espodossolos',
                'Vertissolos',
              ].map((soilType) => DropdownMenuItem(
                value: soilType,
                child: Text(
                  soilType,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    color: Colors.white,
                  ),
                ),
              )).toList(),
              onChanged: (value) {},
              decoration: InputDecoration(
                labelText: 'Tipo de solo',
                labelStyle: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                fillColor: Color(0xFF180F0F),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Dica: Certifique-se de usar um solo bem drenado para ervas',
                hintStyle: TextStyle(
                  fontFamily: 'Manrope',
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
              dropdownColor: Color(0xFF180F0F),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),

            // Dropdown para Clima de Hoje com fundo preto e texto branco
            DropdownButtonFormField<String>(
              items: [
                'Seco',
                'Úmido',
                'Chuvoso',
                'Ensolarado',
                'Nublado',
              ].map((climate) => DropdownMenuItem(
                value: climate,
                child: Text(
                  climate,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    color: Colors.white,
                  ),
                ),
              )).toList(),
              onChanged: (value) {},
              decoration: InputDecoration(
                labelText: 'Qual o clima de hoje?',
                labelStyle: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                fillColor: Color(0xFF180F0F),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              dropdownColor: Color(0xFF180F0F),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),

            // Área de texto para Observações com altura reduzida
            TextField(
              maxLines: 2, // Diminui o número de linhas para deixar a caixa menor
              decoration: InputDecoration(
                hintText: 'Adicione uma observação...',
                hintStyle: TextStyle(
                  fontFamily: 'Manrope',
                  color: Colors.grey,
                ),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 24),

            // Botões Salvar e Cancelar com rotas definidas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Botão Salvar
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/report'); // Navegar para Relatório
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8EAD85),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                  ),
                  child: Text(
                    'Salvar',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                // Botão Cancelar
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Voltar para a tela anterior
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD65A50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                  ),
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      
      // Barra de Navegação Inferior Personalizada
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xFF0F6D5F), // Linha verde no topo da barra
              width: 4, // Aumentando a espessura da linha verde
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Color(0xFFECECEC), // Fundo cinza claro
          selectedItemColor: Color(0xFF0F6D5F), // Verde para o item selecionado
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 24),
              label: 'Início',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart, size: 24),
              label: 'Métricas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 24),
              label: 'Perfil',
            ),
          ],
          currentIndex: 0,
          onTap: (index) {
            // Redirecionamento com base no índice selecionado
            if (index == 0) {
              Navigator.pushNamed(context, '/home');
            } else if (index == 1) {
              Navigator.pushNamed(context, '/report');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/planting');
            }
          },
        ),
      ),
    );
  }
}
