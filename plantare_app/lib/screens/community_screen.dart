import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
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
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "DICAS",
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

            // Community Posts Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCommunityPost(
                    title: '10 dicas para quem está começando a cultivar plantas ou alimentos',
                    content: 'Começar um jardim ou uma horta pode parecer um desafio...',
                    author: 'João',
                    likes: 12,
                    comments: 5,
                    onShare: () {
                      // Share action
                    },
                  ),
                  _buildCommunityPost(
                    title: 'Do Solo à Colheita: Técnicas Essenciais de Cultivo',
                    content: 'O cultivo é uma jornada que começa com a preparação do solo...',
                    author: 'Maria',
                    likes: 8,
                    comments: 2,
                    onShare: () {
                      // Share action
                    },
                  ),
                  _buildCommunityPost(
                    title: 'Hidroponia para Todos: Um Guia Prático',
                    content: 'A hidroponia, uma técnica de cultivo sem solo...',
                    author: 'Luciano',
                    likes: 20,
                    comments: 7,
                    onShare: () {
                      // Share action
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Floating Action Button with Gradient
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
            Navigator.pushNamed(context, '/planting');
          },
          backgroundColor: Colors.transparent, // Torna o fundo do botão invisível
          elevation: 0,
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Bottom Navigation Bar
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
                  Navigator.pushNamed(context, '/home');
                },
              ),
              IconButton(
                icon: Icon(Icons.people),
                onPressed: () {
                  Navigator.pushNamed(context, '/community');
                },
              ),
              SizedBox(width: 40), // Espaço para o botão central
              IconButton(
                icon: Icon(Icons.analytics),
                onPressed: () {
                  Navigator.pushNamed(context, '/report');
                },
              ),
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method for building community post cards
  Widget _buildCommunityPost({
    required String title,
    required String content,
    required String author,
    required int likes,
    required int comments,
    required VoidCallback onShare,
  }) {
    return Card(
      color: Color(0xFFBFBFBF),
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
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Por: $author',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                fontFamily: 'Oswald',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.red, size: 20),
                    SizedBox(width: 4),
                    Text('$likes', style: TextStyle(color: Colors.black)),
                    SizedBox(width: 16),
                    Icon(Icons.comment, color: Colors.black, size: 20),
                    SizedBox(width: 4),
                    Text('$comments', style: TextStyle(color: Colors.black)),
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
