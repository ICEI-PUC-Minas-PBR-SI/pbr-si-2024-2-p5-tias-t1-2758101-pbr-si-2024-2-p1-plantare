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