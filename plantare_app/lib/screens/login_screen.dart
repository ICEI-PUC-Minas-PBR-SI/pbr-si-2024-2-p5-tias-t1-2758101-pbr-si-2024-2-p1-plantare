import 'package:flutter/material.dart';
import 'package:plantare_app/core/app_colors.dart';
import 'package:plantare_app/core/app_text_styles.dart';
import '../database/database_helper.dart'; // Importa o DatabaseHelper para o login

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance; // Instância do DatabaseHelper
  String? errorMessage;

  // Função de login
  Future<void> _login() async {
    String email = _emailController.text;
    String senha = _passwordController.text;

    try {
      // Usa a função login do DatabaseHelper para verificar as credenciais
      var user = await _dbHelper.login(email, senha);

      if (user != null) {
        // Login bem-sucedido, navega para a tela principal
        setState(() {
          errorMessage = null;
        });
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Exibe uma mensagem de erro
        setState(() {
          errorMessage = "E-mail ou senha incorretos.";
        });
      }
    } catch (e) {
      // Exibe uma mensagem de erro para exceções não esperadas
      setState(() {
        errorMessage = "Erro ao conectar ao banco de dados.";
      });
      print("Erro de login: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.highlight,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              // Título com fonte Oswald
              Text(
                'Bem-vindo ao',
                style: TextStyle(
                  fontFamily: 'Oswald', // Fonte Oswald
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              Text(
                'plantare',
                style: TextStyle(
                  fontFamily: 'Oswald', // Fonte Oswald
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF5D2B20), // Cor CA6A52
                ),
              ),
              SizedBox(height: 40),

              // Campo de E-mail com fonte Manrope
              Text(
                'Entre com seu e-mail',
                style: TextStyle(
                  fontFamily: 'Manrope', // Fonte Manrope
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.email, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Campo de Senha com fonte Manrope
              Text(
                'Entre com sua senha',
                style: TextStyle(
                  fontFamily: 'Manrope', // Fonte Manrope
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.lock, color: Colors.black),
                  suffixIcon: Icon(Icons.visibility, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 8),

              // Exibição da mensagem de erro, se houver
              if (errorMessage != null) ...[
                SizedBox(height: 8),
                Text(
                  errorMessage!,
                  style: TextStyle(
                    fontFamily: 'Manrope', // Fonte Manrope
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
              ],

              // Link "Esqueci minha senha" com fonte Manrope
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    // Ação para "Esqueci minha senha"
                  },
                  child: Text(
                    'Esqueci minha senha',
                    style: TextStyle(
                      fontFamily: 'Manrope', // Fonte Manrope
                      color: Color(0xFF5D2B20), // Cor CA6A52
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Botão "Acessar" com fonte Manrope
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow, // Fundo amarelo clarinho
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    minimumSize: Size(double.infinity, 48),
                  ),
                  onPressed: _login, // Chama a função _login ao pressionar
                  child: Text(
                    'Acessar',
                    style: TextStyle(
                      fontFamily: 'Manrope', // Fonte Manrope
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 80),

              // Link de "Não tem uma conta? Cadastre-se" com fonte Manrope
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Não tem uma conta?',
                      style: TextStyle(
                        fontFamily: 'Manrope', // Fonte Manrope
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text(
                        'Cadastre-se',
                        style: TextStyle(
                          fontFamily: 'Manrope', // Fonte Manrope
                          color: Color(0xFF5D2B20), // Cor CA6A52
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}