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
              TextSpan(text: 'Olá, '),
              TextSpan(
                text: 'Abner',
                style: TextStyle(
                  color: Color(0xFF225149), // Verde específico para "Abner"
                ),
              ),
              TextSpan(text: ' ! Vamos cultivar juntos ?'),
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
              '/tutorials', // Navegação para página de tutoriais
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
      // Barra de navegação inferior personalizada
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
          backgroundColor: Color(0xFFECECEC), // Cinza claro para fundo da barra
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
            // Redireciona para as telas específicas com base no índice selecionado
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

  // Definição do método _buildOption com fontes ajustadas, ícones à direita, e navegação personalizada
  Widget _buildOption(BuildContext context, String title, String subtitle, String iconPath, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, // Largura ajustada para o tamanho do frame
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
            Navigator.pushNamed(context, route); // Navegação ao clicar no botão
          },
        ),
      ),
    );
  }
}
