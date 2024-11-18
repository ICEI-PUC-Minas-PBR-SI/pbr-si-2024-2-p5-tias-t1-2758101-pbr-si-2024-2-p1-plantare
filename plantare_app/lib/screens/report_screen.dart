import 'package:flutter/material.dart';
import 'package:plantare_app/core/app_colors.dart';
import 'package:plantare_app/core/app_text_styles.dart';
import '../main.dart';

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9), // Fundo cinza claro
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Botão de voltar com título
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF4A4A4A), // Fundo cinza escuro
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

            // Saudação com ícone
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontFamily: 'Oswald', // Fonte Oswald
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                ],
              ),
            ),
            SizedBox(height: 8),

            // Fundo preto para os ícones de folhas
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              decoration: BoxDecoration(
                color: Color(0xFF484C52), // Fundo preto
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/images/leaf_icon_green.png', height: 60),
                  Image.asset('assets/images/leaf_icon_yellow.png', height: 60),
                  Image.asset('assets/images/flower_icon_pink.png', height: 60),
                  Image.asset('assets/images/leaf_icon_red.png', height: 60),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Título "Detalhes da sua plantação"
            Text(
              'Detalhes da sua plantação',
              style: TextStyle(
                fontFamily: 'Oswald',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),

            // Caixa principal com detalhes da plantação
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF0F6D5F), // Fundo verde escuro
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  // Fundo translúcido para o "feijão"
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0x99F2E6DA), // Fundo translúcido
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        // Ícone de semente com fundo claro
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xFFE5E5E5),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset('assets/images/seed_icon.png', height: 40),
                        ),
                        SizedBox(width: 8),
                        // Informações do feijão
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pé de feijão',
                              style: TextStyle(
                                fontFamily: 'Oswald',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '3 semanas',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        // Gráfico de progresso
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '70%',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFF65600),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  // Indicadores de Água e Terra e Fertilizante
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _buildIndicatorBox('Água', 'Ruim', '20%'),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _buildIndicatorBox('Terra e Fertilizer', 'Bom', '80%'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),

            // Botão de edição
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/planting'); // Navegar para PlantingScreen
                  },
                  backgroundColor: Color(0xFFF65600), // Cor do botão
                  child: Icon(Icons.edit, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),

      // Barra de navegação inferior
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xFF0F6D5F),
              width: 4,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Color(0xFFECECEC),
          selectedItemColor: Color(0xFF225149),
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
          currentIndex: 1,
          onTap: (index) {
            if (index == 0) {
              Navigator.pushNamed(context, '/home');
            } else if (index == 1) {
              Navigator.pushNamed(context, '/report');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/profile');
            }
          },
        ),
      ),
    );
  }

  // Método para construir os indicadores de "Água" e "Terra e Fertilizante"
  Widget _buildIndicatorBox(String title, String quality, String percentage) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFF2E6DA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Text(
              quality,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Text(
              percentage,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ),
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Oswald',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
