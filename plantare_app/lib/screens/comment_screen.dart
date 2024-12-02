import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../main.dart';
import '../database/database_helper.dart';

class CommentScreen extends StatefulWidget {
  final String userId = UserSession().getLoggedInUser() ?? '';

  CommentScreen();

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final String userId = UserSession().getLoggedInUser() ?? '';
  final TextEditingController _commentController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF04BB86),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/onboarding_image.png',
              height: 40,
              width: 40,
            ),
            SizedBox(width: 8),
            Text(
              "PLANTARE",
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Spacer(),
            Icon(Icons.search, color: Colors.white),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('comentarios')
                    .orderBy('timestamp', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData) {
                    return Center(child: Text('Sem comentários disponíveis.'));
                  }

                  final comments = snapshot.data!.docs;

                  Map<String, List<QueryDocumentSnapshot>> commentsByParent =
                      {};
                  for (var comment in comments) {
                    final commentData = comment.data() as Map<String, dynamic>?;

                    String parentId = (commentData != null &&
                            commentData.containsKey('parentId'))
                        ? commentData['parentId'] as String
                        : 'root';

                    if (!commentsByParent.containsKey(parentId)) {
                      commentsByParent[parentId] = [];
                    }
                    commentsByParent[parentId]!.add(comment);
                  }

                  return ListView(
                    children: _buildCommentTree('root', commentsByParent, 0),
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
    );
  }

  List<Widget> _buildCommentTree(String parentId,
      Map<String, List<QueryDocumentSnapshot>> commentsByParent, int depth) {
    if (!commentsByParent.containsKey(parentId)) {
      return [];
    }

    return commentsByParent[parentId]!.map((commentData) {
      String commentId = commentData.id;
      final commentContent = commentData.data() as Map<String, dynamic>?;

      return FutureBuilder<String?>(
        future: _getUserName(commentContent?['usuario'] ?? ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text("Erro ao carregar nome");
          }

          String userName = snapshot.data ?? '';
          String timestamp = commentContent?['timestamp'] != null
              ? (commentContent?['timestamp'] as Timestamp).toDate().toString()
              : '00:00 AM - 00/00/0000';

          return Padding(
            padding: EdgeInsets.only(left: depth * 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildComment(
                  userName: userName,
                  comment: commentContent?['comentario'] ?? '',
                  timestamp: timestamp,
                  onReply: () {
                    _showReplyDialog(commentId);
                  },
                ),
                ..._buildCommentTree(commentId, commentsByParent, depth + 1),
              ],
            ),
          );
        },
      );
    }).toList();
  }

  Widget _buildComment({
    required String userName,
    required String comment,
    required String timestamp,
    required VoidCallback onReply,
  }) {
    bool isLiked = false;
    bool isHot = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.yellow[700],
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      userName,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 48.0),
                child: Text(
                  comment,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 48.0, top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      timestamp,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: isLiked ? Colors.red : Colors.grey,
                            size: 16,
                          ),
                          onPressed: () {
                            setState(() {
                              isLiked = !isLiked;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.whatshot,
                            color: isHot ? Colors.amber : Colors.grey,
                            size: 16,
                          ),
                          onPressed: () {
                            setState(() {
                              isHot = !isHot;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 48.0, top: 4),
                child: Row(
                  children: [
                    TextButton.icon(
                      onPressed: onReply,
                      icon: Icon(Icons.reply, color: Color(0xFFF65600)),
                      label: Text(
                        'Responder',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12,
                          color: Color(0xFFF65600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showReplyDialog(String parentId) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController replyController = TextEditingController();
        return AlertDialog(
          title: Text('Responder comentário'),
          content: TextField(
            controller: replyController,
            decoration: InputDecoration(hintText: 'Escreva sua resposta...'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                addCommentWithId(userId, replyController.text,
                    parentId: parentId);
                Navigator.pop(context);
              },
              child: Text('Enviar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> addCommentWithId(String userId, String comment,
      {String? parentId}) async {
    try {
      DocumentReference lastIdRef =
          _firestore.collection('metadata').doc('lastCommentId');
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
        'usuario': userId,
        'comentario': comment,
        'parentId': parentId ?? 'root',
        'timestamp': FieldValue.serverTimestamp(),
      });

      setState(() {});
    } catch (e) {
      print("Erro ao adicionar comentário: $e");
    }
  }

  Widget _buildCommentInput() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Escreva um comentário...',
                hintStyle: TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.grey,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        IconButton(
          icon: Icon(Icons.send, color: Color(0xFF00796B)),
          onPressed: () {
            addCommentWithId(userId, _commentController.text);
            _commentController.clear();
            setState(() {});
          },
        ),
      ],
    );
  }

  Future<String?> _getUserName(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('usuarios').doc(userId).get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>?;
        return userData?['Nome'];
      }
      return null;
    } catch (e) {
      print('Erro ao buscar nome do usuário: $e');
      return null;
    }
  }
}
