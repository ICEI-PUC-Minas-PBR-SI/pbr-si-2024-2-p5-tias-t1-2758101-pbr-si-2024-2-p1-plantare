import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'tipdetail_screen.dart';

class CommunityScreen extends StatefulWidget {
  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  // Carregar artigos do arquivo JSON
  Future<void> _loadArticles() async {
    try {
      final String response = await rootBundle.loadString('assets/artigos.json');
      final List<dynamic> data = json.decode(response);

      // Verifique se os dados foram carregados corretamente
      print("Artigos carregados: $data");

      setState(() {
        articles = data.map((article) => Article.fromJson(article)).toList();
      });
    } catch (e) {
      print("Erro ao carregar os artigos: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header (adaptado para CommunityScreen)
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
                    'assets/images/onboarding_image.png',  // Logo da Plantare
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
                  Icon(Icons.search, color: Colors.white),  // Ícone de busca
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
                      icon: Icon(Icons.arrow_back, color: Colors.grey),  // Ícone de voltar
                      onPressed: () {
                        Navigator.pop(context);  // Volta para a tela anterior
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "DICAS",  // Título da tela para CommunityScreen
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
            
            // Lista de artigos (continuando com a mesma estrutura)
            articles.isEmpty
                ? Center(child: CircularProgressIndicator()) // Exibe carregando
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      return _buildCommunityPost(
                        context: context,
                        title: article.title,
                        content: article.content.substring(0, 100) + "...", // Exibir uma prévia maior do conteúdo
                        author: 'Autor Desconhecido',
                        fullContent: article.content,
                      );
                    },
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
                  Navigator.pushNamed(context, '/report'); // Navegar para Relatórios
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

  // Método para construir o post de cada artigo
  Widget _buildCommunityPost({
    required BuildContext context,
    required String title,
    required String content,
    required String author,
    required String fullContent,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TipDetailScreen(
              title: title,
              content: fullContent,
              author: author,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),  // Espaçamento entre os artigos
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(16),  // Borda arredondada
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3), // Sombra suave
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Oswald',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Por: $author',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 12),
            Text(
              content,
              style: TextStyle(
                fontFamily: 'Oswald',
                fontSize: 16,
                color: Colors.black87,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,  // Trunca o texto se necessário
            ),
          ],
        ),
      ),
    );
  }
}

// Classe Article para armazenar dados dos artigos
class Article {
  final String title;
  final String content;

  Article({required this.title, required this.content});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      content: json['content'],
    );
  }
}
