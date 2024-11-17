import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  bool _isHovering = false;

  // Função para enviar o e-mail de recuperação
  Future<void> _sendPasswordResetEmail() async {
    String email = _emailController.text.trim();

    if (email.isEmpty) {
      _showErrorDialog("Por favor, insira um e-mail válido.");
      return;
    }

    try {
      // Verifica se o e-mail existe no Firestore
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('usuarios') // Certifique-se de que esta é a coleção correta
          .where('Email', isEqualTo: email) // Certifique-se de que 'Email' corresponde ao Firestore
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Se o e-mail for encontrado, simule o envio do e-mail
        _showSuccessDialog("Um e-mail de redefinição de senha foi enviado para $email.");
      } else {
        // Se o e-mail não for encontrado
        _showErrorDialog("E-mail não encontrado. Verifique o endereço digitado.");
      }
    } catch (e) {
      // Caso haja algum erro no processo
      _showErrorDialog("Erro ao tentar enviar o e-mail de recuperação. Tente novamente.");
      print("Erro: $e");
    }
  }

  // Exibe um diálogo de sucesso
  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Sucesso",
            style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Text(
            message,
            style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context); // Volta para a tela de login
              },
              child: Text(
                "OK",
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Exibe um diálogo de erro
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Erro",
            style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Text(
            message,
            style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w400),
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
                  color: const Color.fromARGB(255, 0, 0, 0),
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
                      "Recupere sua conta",
                      style: GoogleFonts.outfit(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Campo E-mail
                  SizedBox(
                    width: 305,
                    height: 40,
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Insira seu e-mail:",
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

                  SizedBox(height: 15),

                  Center(
                    child: Container(
                      width: 300,
                      child: Text(
                        "Não se preocupe, enviaremos instruções para a recuperação de senha!",
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  // Botão de Recuperar Senha
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
                      onPressed: _sendPasswordResetEmail,
                      child: Text(
                        "Recuperar senha",
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Link para voltar ao login
                  MouseRegion(
                    onEnter: (_) {
                      setState(() {
                        _isHovering = true;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        _isHovering = false;
                      });
                    },
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: _isHovering ? 15.0 : 10.0,
                          vertical: _isHovering ? 8.0 : 5.0,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Voltar ao início",
                            style: GoogleFonts.outfit(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
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
