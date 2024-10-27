import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';

class CommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFD9D9D9),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seção de botão de voltar
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

            // Saudação ao usuário
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontFamily: 'Oswald',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(text: 'Olá, '),
                  TextSpan(
                    text: 'Abner ',
                    style: TextStyle(color: Color(0xFF225149)),
                  ),
                  TextSpan(text: 'seja bem-vindo a comunidade'),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Campo de busca e botões de ação
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFB9C0C9),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'pesquisa',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.add, color: Color(0xFFF65600)),
                  onPressed: () {
                    // Ação para criar nova postagem
                  },
                ),
                IconButton(
                  icon: Icon(Icons.notifications, color: Color(0xFFF65600)),
                  onPressed: () {
                    // Ação para notificações
                  },
                ),
              ],
            ),
            SizedBox(height: 16),

            // Lista de Postagens
            Expanded(
              child: ListView(
                children: [
                  _buildCommunityPost(
                    title: 'Melhor Solo para Tomate 🌱',
                    author: 'João',
                    likes: 12,
                    comments: 5,
                    onShare: () {
                      // Ação de compartilhamento
                    },
                  ),
                  _buildCommunityPost(
                    title: 'Qual melhor irrigação?',
                    author: 'Maria',
                    likes: 8,
                    comments: 2,
                    onShare: () {
                      // Ação de compartilhamento
                    },
                  ),
                  _buildCommunityPost(
                    title: 'Quando plantar feijão 🌱',
                    author: 'Luciano',
                    likes: 20,
                    comments: 7,
                    onShare: () {
                      // Ação de compartilhamento
                    },
                  ),
                  _buildCommunityPost(
                    title: 'Quando plantar morangos?',
                    author: 'Pedro J.',
                    likes: 15,
                    comments: 3,
                    onShare: () {
                      // Ação de compartilhamento
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Barra de navegação inferior personalizada
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
              icon: Icon(Icons.analytics, size: 24),
              label: 'Métricas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 24),
              label: 'Perfil',
            ),
          ],
          currentIndex: 0,
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

  // Método auxiliar para construir postagens da comunidade
  Widget _buildCommunityPost({
    required String title,
    required String author,
    required int likes,
    required int comments,
    required VoidCallback onShare,
  }) {
    return Card(
      color: Color(0xFF1E1E1E), // Alterado para cor conforme solicitado
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Oswald',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Por: $author',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.red, size: 20),
                    SizedBox(width: 4),
                    Text('$likes', style: TextStyle(color: Colors.white70)),
                    SizedBox(width: 16),
                    Icon(Icons.comment, color: Colors.black, size: 20),
                    SizedBox(width: 4),
                    Text('$comments', style: TextStyle(color: Colors.white70)),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.share, color: Colors.black),
                  onPressed: onShare,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
