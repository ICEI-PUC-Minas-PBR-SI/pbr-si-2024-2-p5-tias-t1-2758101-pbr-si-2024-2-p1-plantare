import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentScreen extends StatefulWidget {
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, bool> likedComments = {};

  Future<void> addCommentWithId(String nomeUsuario, String comentario, {String? parentId}) async {
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
        'parentId': parentId ?? 'root',
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Erro ao adicionar comentário: $e");
    }
  }

  void _showShareOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.facebook, color: Colors.blue),
              title: Text('Compartilhar no Facebook'),
              onTap: () {
                Navigator.pop(context);
                print('Compartilhado no Facebook');
              },
            ),
            ListTile(
              leading: Icon(Icons.share, color: Colors.purple),
              title: Text('Compartilhar no Instagram'),
              onTap: () {
                Navigator.pop(context);
                print('Compartilhado no Instagram');
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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

                  Map<String, List<QueryDocumentSnapshot>> commentsByParent = {};
                  for (var comment in comments) {
                    final commentData = comment.data() as Map<String, dynamic>?;

                    String parentId = (commentData != null && commentData.containsKey('parentId'))
                        ? commentData['parentId'] as String
                        : 'root';

                    if (!commentsByParent.containsKey(parentId)) {
                      commentsByParent[parentId] = [];
                    }
                    commentsByParent[parentId]!.add(comment);
                  }

                  return ListView(
                    children: _buildCommentTree('root', commentsByParent),
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

  List<Widget> _buildCommentTree(String parentId, Map<String, List<QueryDocumentSnapshot>> commentsByParent) {
    if (!commentsByParent.containsKey(parentId)) {
      return [];
    }

    return commentsByParent[parentId]!.map((commentData) {
      String commentId = commentData.id;
      final commentContent = commentData.data() as Map<String, dynamic>?;

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 5,
            color: Colors.green,
            margin: EdgeInsets.only(right: 8),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildComment(
                  userName: commentContent?['nomeUsuario'] ?? 'Anônimo',
                  comment: commentContent?['comentario'] ?? '',
                  onReply: () {
                    _showReplyDialog(commentId);
                  },
                ),
                ..._buildCommentTree(commentId, commentsByParent),
              ],
            ),
          ),
        ],
      );
    }).toList();
  }

  Widget _buildComment({
    required String userName,
    required String comment,
    required VoidCallback onReply,
  }) {
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
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        likedComments[comment] == true ? Icons.favorite : Icons.favorite_border,
                        color: likedComments[comment] == true ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          likedComments[comment] = !(likedComments[comment] ?? false);
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.share, color: Colors.blue),
                      onPressed: _showShareOptions,
                    ),
                  ],
                ),
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
                addCommentWithId('Você', replyController.text, parentId: parentId);
                Navigator.pop(context);
              },
              child: Text('Enviar'),
            ),
          ],
        );
      },
    );
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
            addCommentWithId('Você', _commentController.text);
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
