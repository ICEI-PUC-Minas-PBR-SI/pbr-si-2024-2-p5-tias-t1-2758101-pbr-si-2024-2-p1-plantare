import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9), // Fundo cinza claro
      appBar: AppBar(
        backgroundColor: Color(0xFFD9D9D9), // Cor do fundo do AppBar igual ao fundo da tela
        elevation: 0,
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            style: TextStyle(
              fontFamily: 'Oswald', // Fonte Oswald para o título
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(text: 'Olá, Vamos cultivar juntos ? '),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo de busca arredondado com cinza claro
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFB9C0C9), // Cinza claro para a barra de pesquisa
                borderRadius: BorderRadius.circular(30), // Borda arredondada
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Busque aqui',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Manrope', // Fonte Manrope
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
            SizedBox(height: 20), // Espaço entre o campo de busca e os botões

            // Opções de navegação com ícones do lado direito
            _buildOption(
              context,
              'Novo cultivo',
              'Prepare seu plantio',
              'assets/images/watering_icon.png',
              '/planting', // Navegação para a página de plantio
            ),
            _buildOption(
              context,
              'Dica e tutoriais',
              'Aprenda com especialistas',
              'assets/images/metrics_icon.png',
              '/community', // Navegação para página de tutoriais
            ),
            _buildOption(
              context,
              'Comunidade',
              'Compartilhe e aprenda',
              'assets/images/community_icon.png',
              '/comment', // Navegação para a página de comunidade
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
                  Navigator.pushNamed(context, '/profile'); // Navegar para Perfil
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
          color: Colors.black, // Fundo preto dos botões
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
              color: Colors.white, // Texto branco
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              fontFamily: 'Manrope', // Fonte Manrope para o subtítulo
              color: Colors.grey[300], // Texto do subtítulo mais claro
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
