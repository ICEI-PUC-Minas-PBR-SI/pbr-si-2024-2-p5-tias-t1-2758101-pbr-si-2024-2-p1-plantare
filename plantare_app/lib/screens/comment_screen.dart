import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../main.dart';

class CommentScreen extends StatefulWidget {
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
Future<String?> getUserNameById(String userId) async {
  try {
    // Obtém o documento do usuário pelo ID
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(userId)
        .get();

    if (doc.exists) {
      // Retorna o nome do usuário
      return doc['Nome'] as String?;
    } else {
      print("Usuário com ID $userId não encontrado!");
      return null;
    }
  } catch (e) {
    print("Erro ao buscar usuário: $e");
    return null;
  }
}
  Future<void> addCommentWithId(String nomeUsuario, String comentario) async {
  try {
    DocumentReference lastIdRef = _firestore.collection('metadata').doc('lastCommentId');
    DocumentSnapshot lastIdSnapshot = await lastIdRef.get();

    int newCommentId;
    if (lastIdSnapshot.exists) {
      newCommentId = lastIdSnapshot['value'] + 1;
      await lastIdRef.update({'value': newCommentId});
    } else {
      newCommentId = 1;
      await lastIdRef.set({'value': newCommentId});
    }

    await _firestore.collection('comentarios').doc(newCommentId.toString()).set({
      'nomeUsuario': nomeUsuario,
      'comentario': comentario,
      'timestamp': FieldValue.serverTimestamp(),
    });

    print("Comentário adicionado com sucesso! ID: $newCommentId");
  } catch (e) {
    print("Erro ao adicionar comentário: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD9D9D9),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Deixe sua contribuição',
          style: TextStyle(
            fontFamily: 'Oswald',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('comentarios').orderBy('timestamp', descending: true).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData) {
                    return Center(child: Text('Sem comentários disponíveis.'));
                  }

                  final comments = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final commentData = comments[index];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildComment(
                            userName: commentData['nomeUsuario'] ?? 'Anônimo',
                            comment: commentData['comentario'] ?? ''
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            Divider(height: 1, color: Colors.grey),
            SizedBox(height: 8),
            _buildCommentInput(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildComment({
    required String userName,
    required String comment
  }) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFFB8DFD8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: Colors.yellow[700], size: 24),
              SizedBox(width: 8),
              Text(
                userName,
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            comment,
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentInput() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Color(0xFFE5E5E5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Escreva um comentário...',
                hintStyle: TextStyle(
                  fontFamily: 'Manrope',
                  color: Colors.grey,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        IconButton(
          icon: Icon(Icons.send, color: Color(0xFF225149)),
          onPressed: () async {
            String? userName = await getUserNameById(UserSession().getLoggedInUser() ?? "");
            if (userName != null) {
              addCommentWithId(userName, _commentController.text);
            } else {
              print("Erro: Nome do usuário não encontrado!");
            }
          },
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
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
    );
  }
}
