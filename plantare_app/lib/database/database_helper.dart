import 'package:flutter/material.dart';
import 'package:plantare_app/core/app_colors.dart';
import '../database/database_helper.dart';
// database_helper.dart
import 'database_helper_mobile.dart' if (dart.library.html) 'database_helper_web.dart';

typedef DatabaseHelper = DatabaseHelperImplementation;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final dynamic _dbHelper = DatabaseHelper.instance;
  String? errorMessage;

  Future<void> _login() async {
    String email = _emailController.text;
    String senha = _passwordController.text;

    try {
      var user = await _dbHelper.login(email, senha);
      if (user != null) {
        setState(() {
          errorMessage = null;
        });
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          errorMessage = "E-mail ou senha incorretos.";
        });
      }
    } catch (e) {
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
              Text('Bem-vindo ao', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.black)),
              Text('plantare', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Color(0xFF5D2B20))),
              SizedBox(height: 40),
              Text('Entre com seu e-mail', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  filled: true, fillColor: Colors.white,
                  prefixIcon: Icon(Icons.email, color: Colors.black),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                ),
              ),
              SizedBox(height: 16),
              Text('Entre com sua senha', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true, fillColor: Colors.white,
                  prefixIcon: Icon(Icons.lock, color: Colors.black),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                ),
              ),
              SizedBox(height: 8),
              if (errorMessage != null) Text(errorMessage!, style: TextStyle(color: Colors.red, fontSize: 14)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                    minimumSize: Size(double.infinity, 48),
                  ),
                  onPressed: _login,
                  child: Text('Acessar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}