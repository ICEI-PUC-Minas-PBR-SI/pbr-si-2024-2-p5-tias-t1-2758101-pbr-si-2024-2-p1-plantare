import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header (AppBar Customizada)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF04BB86), Color(0xFF225149)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/onboarding_image.png',
                    height: 40,
                    width: 40,
                  ),
                  Text(
                    "PLANTARE",
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Icon(Icons.search, color: Colors.white),
                ],
              ),
            ),

            // Title and instructions
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.grey),
                      onPressed: () {
                        Navigator.pop(context); // Navegar para a tela anterior
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "OLÁ, O QUE VAMOS CULTIVAR?",
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Corpo da página com as opções de navegação
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Opções de navegação com ícones do lado direito
                  _buildOption(
                    context,
                    'Novo cultivo',
                    'Prepare seu plantio',
                    'assets/images/flower_icon_pink.png',
                    '/planting', // Navegação para a página de plantio
                  ),
                  SizedBox(height: 16), // Espaço entre os botões

                  _buildOption(
                    context,
                    'Dica e tutoriais',
                    'Aprenda com especialistas',
                    'assets/images/leaf_icon_green.png',
                    '/community', // Navegação para página de tutoriais
                  ),
                  SizedBox(height: 16), // Espaço entre os botões

                  _buildOption(
                    context,
                    'Comunidade',
                    'Compartilhe e aprenda',
                    'assets/images/leaf_icon_red.png',
                    '/comment', // Navegação para a página de comunidade
                  ),
                ],
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
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.pushNamed(context, '/home'); // Navegar para Home
                },
              ),
              IconButton(
                icon: Icon(Icons.people),
                onPressed: () {
                  Navigator.pushNamed(context, '/community'); // Navegar para Comunidade
                },
              ),
              SizedBox(width: 40), // Espaço para o botão central
              IconButton(
                icon: Icon(Icons.analytics),
                onPressed: () {
                  Navigator.pushNamed(context, '/report'); // Navegar para Métricas
                },
              ),
              IconButton(
                icon: Icon(Icons.person),
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

  // Método auxiliar para criar os blocos de opções no corpo
  Widget _buildOption(
    BuildContext context,
    String title,
    String subtitle,
    String iconPath,
    String route,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, // Largura ajustada
        decoration: BoxDecoration(
          color:Color(0xFFBFBFBF), // Fundo preto dos botões
          borderRadius: BorderRadius.circular(20), // Borda arredondada
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'Oswald', // Fonte Oswald para o título
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Texto branco
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              fontFamily: 'Manrope', // Fonte Manrope para o subtítulo
              color: Colors.black, // Texto do subtítulo mais claro
              fontSize: 14,
            ),
          ),
          trailing: Image.asset(
            iconPath,
            height: 40, // Ícone com tamanho fixo
          ),
          onTap: () {
            Navigator.pushNamed(context, route); // Navegar ao clicar
          },
        ),
      ),
    );
  }
}
