import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../main.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isHovering = false; 
  bool _rememberPassword = false;
  bool _obscurePassword = true; // Controle de visibilidade da senha

  // Função de login
  Future<void> _login() async {
    String email = _emailController.text.trim();
    String senha = _passwordController.text.trim();

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('usuarios')
          .where('Email', isEqualTo: email)
          .where('Senha', isEqualTo: senha)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Login bem-sucedido
        DocumentSnapshot doc = querySnapshot.docs.first;
        Navigator.pushReplacementNamed(context, '/home'); // Navega para a tela principal
        loginUser(doc.id);
      } else {
        // Exibe popup de erro
        _showErrorDialog("E-mail ou senha incorretos.");
      }
    } catch (e) {
      // Exibe popup de erro para problemas de conexão
      _showErrorDialog("Erro ao conectar ao servidor.");
      print("Erro: $e");
    }
  }

  // Exibe um diálogo de erro
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Erro de Login",
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            message,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: Text(
                "OK",
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 390,
          height: 844,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF04BB86),
                  Color(0xFF225149),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 250,
                      height: 200,
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      "Bem-vindo",
                      style: GoogleFonts.outfit(
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Text(
                      "Por favor insira seus dados",
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: 305,
                    height: 40,
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "E-mail",
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 305,
                    height: 40,
                    child: TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: "Senha",
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(
                              _obscurePassword ? Icons.visibility_off : Icons.visibility,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _rememberPassword = !_rememberPassword;
                                });
                              },
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _rememberPassword ? Colors.black : Colors.white,
                                ),
                                child: _rememberPassword
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 10,
                                      )
                                    : null,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Lembrar minha senha",
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        MouseRegion(
                          onEnter: (_) {
                            setState(() {
                              _isHovering = true; // Ativa o hover
                            });
                          },
                          onExit: (_) {
                            setState(() {
                              _isHovering = false; // Desativa o hover
                            });
                          },
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/forgotpassword'); // Redireciona para a tela de "Esqueceu sua senha"
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: _isHovering ? 10.0 : 10.0, // Padding ajustado no hover
                                vertical: _isHovering ? 5.0 : 5.0,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: 5),
                                Text(
                                  "Esqueceu sua senha?",
                                  style: GoogleFonts.outfit(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 305,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: _login,
                      child: Text(
                        "Entrar",
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 220),

                  // Texto "Não tem uma conta?"
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register'); // Redireciona para a tela de cadastro
                          },
                          child: Text(
                            "Não tem uma conta ? Cadastre-se",
                            style: GoogleFonts.outfit(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
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
        ),
      ),
    );
  }
}
