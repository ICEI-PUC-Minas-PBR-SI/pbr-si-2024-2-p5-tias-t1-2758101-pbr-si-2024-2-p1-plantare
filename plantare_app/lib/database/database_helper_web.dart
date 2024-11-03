import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirestoreExample extends StatefulWidget {
  @override
  _FirestoreExampleState createState() => _FirestoreExampleState();
}

class _FirestoreExampleState extends State<FirestoreExample> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _getData() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users').get();
      for (var doc in querySnapshot.docs) {
        print("Nome: ${doc['name']}");
      }
    } catch (e) {
      print("Erro ao buscar dados: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firestore Example")),
      body: Center(
        child: Text("Verifique o console para os dados."),
      ),
    );
  }
}

class DatabaseHelperImplementation {
  static final DatabaseHelperImplementation instance = DatabaseHelperImplementation._privateConstructor();
  DatabaseHelperImplementation._privateConstructor();

  final List<Map<String, String>> _users = [
    {'Nome': 'Abner', 'Email': 'abner@gmail.com', 'Senha': '!Abner!@'},
    // Adicione mais usuários conforme necessário
  ];

  Future<Map<String, String>?> login(String email, String senha) async {
    for (var user in _users) {
      if (user['Email'] == email && user['Senha'] == senha) {
        return user;
      }
    }
    return null;
  }
}