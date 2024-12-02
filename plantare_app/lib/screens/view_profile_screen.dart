import 'package:flutter/material.dart';

class ViewProfileScreen extends StatelessWidget {
  final String profileImage = 'assets/images/sample_profile.png'; // Exemplo
  final String fullName = 'Abner Amorim'; // Substitua com os dados reais
  final String email = 'abner@gmail.com'; // Substitua com os dados reais
  final String username = '@abner_123'; // Substitua com os dados reais

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
        backgroundColor: const Color(0xFF04BB86),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Foto do perfil
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(profileImage), // Caminho da imagem
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 16),

            // Nome completo
            Text(
              fullName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // E-mail
            Text(
              email,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),

            // Nome de usuário
            Text(
              username,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}