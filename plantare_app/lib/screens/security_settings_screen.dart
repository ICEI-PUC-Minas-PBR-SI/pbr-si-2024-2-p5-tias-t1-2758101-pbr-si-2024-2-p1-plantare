import 'package:flutter/material.dart';

class SecuritySettingsScreen extends StatefulWidget {
  @override
  _SecuritySettingsScreenState createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool isPasswordValidLength = false;
  bool isPasswordValidNumber = false;
  bool isPasswordValidSpecial = false;
  bool isPasswordiqual = false;

  String password = '';
  String confirmPassword = '';

  void _validatePassword(String value) {
    setState(() {
      password = value;

      isPasswordValidLength = value.length >= 8;
      isPasswordValidNumber = value.contains(RegExp(r'[0-9]'));
      isPasswordValidSpecial = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

      isPasswordiqual = password.isNotEmpty &&
          confirmPassword.isNotEmpty &&
          password == confirmPassword;
    });
  }

  void _validateConfirmPassword(String value) {
    setState(() {
      confirmPassword = value;

      isPasswordiqual = password.isNotEmpty &&
          confirmPassword.isNotEmpty &&
          password == confirmPassword;
    });
  }

  void _saveChanges() {
    if (!isPasswordiqual || !isPasswordValidLength || !isPasswordValidNumber || !isPasswordValidSpecial) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Certifique-se de que todos os requisitos de senha foram atendidos.'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Configurações atualizadas com sucesso!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações de Segurança'),
        backgroundColor: const Color(0xFF04BB86),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Alterar E-mail',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Novo E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Alterar Senha',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: currentPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha atual',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                onChanged: _validatePassword,
                decoration: InputDecoration(
                  labelText: 'Nova senha',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                onChanged: _validateConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirmação nova senha',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRequirementItem('Pelo menos 8 caracteres', isPasswordValidLength),
                    _buildRequirementItem('Pelo menos 1 número', isPasswordValidNumber),
                    _buildRequirementItem('Pelo menos 1 caractere especial', isPasswordValidSpecial),
                    _buildRequirementItem('As senhas devem se coincidir', isPasswordiqual),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Salvar Alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequirementItem(String text, bool met) {
    return Row(
      children: [
        Icon(
          met ? Icons.check_circle : Icons.circle_outlined,
          color: met ? Colors.green : Colors.grey,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: met ? Colors.green : Colors.grey,
          ),
        ),
      ],
    );
  }
}