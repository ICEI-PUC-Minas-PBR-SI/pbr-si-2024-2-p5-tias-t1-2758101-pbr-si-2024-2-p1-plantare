import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantare_app/database/database_helper.dart'; // Certifique-se de que este import esteja correto

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirestoreService firestoreService = FirestoreService();

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isCheckboxChecked = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isPasswordValidLength = false;
  bool isPasswordValidNumber = false;
  bool isPasswordValidSpecial = false;
  bool showRequirements = true;
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

  void _registerUser() async {
    String nome = nomeController.text.trim();
    String email = emailController.text.trim();
    String senha = passwordController.text.trim();

    if (nome.isEmpty || email.isEmpty || senha.isEmpty) {
      _showErrorDialog("Todos os campos são obrigatórios.");
      return;
    }

    if (!isPasswordiqual || !isPasswordValidLength || !isPasswordValidNumber || !isPasswordValidSpecial) {
      _showErrorDialog("Certifique-se de que todos os requisitos de senha foram atendidos.");
      return;
    }

    try {
      // Registra o usuário no banco de dados
      await firestoreService.registerUser(nome, email, senha);

      // Mostra o diálogo de sucesso e redireciona para a tela de onboarding
      _showSuccessDialog("Conta criada com sucesso!");
    } catch (e) {
      _showErrorDialog("Erro ao criar conta: ${e.toString()}");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Erro", style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        content: Text(message, style: GoogleFonts.outfit()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK", style: GoogleFonts.outfit(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Sucesso", style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        content: Text(message, style: GoogleFonts.outfit()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Fecha o diálogo
              Navigator.pushReplacementNamed(context, '/'); // Redireciona para a tela de onboarding
            },
            child: Text("OK", style: GoogleFonts.outfit(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
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
                  SizedBox(height: 25),
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 250,
                      height: 200,
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Text(
                      "Crie sua conta",
                      style: GoogleFonts.outfit(
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
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
                  SizedBox(height: 15),

                  // Campos de Entrada
                  _buildTextField("Insira seu nome", nomeController, false, null, null),
                  SizedBox(height: 20),
                  _buildTextField("Seu melhor e-mail", emailController, false, null, null),
                  SizedBox(height: 20),
                  _buildTextField(
                    "Insira sua senha",
                    passwordController,
                    true,
                    isPasswordVisible,
                    () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    onChanged: _validatePassword,
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    "Confirme sua senha",
                    confirmPasswordController,
                    true,
                    isConfirmPasswordVisible,
                    () {
                      setState(() {
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
                      });
                    },
                    onChanged: _validateConfirmPassword,
                  ),
                  SizedBox(height: 15),

                  // Requisitos de Senha
                  if (showRequirements)
                    Container(
                      width: 280,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRequirementItem('As senhas devem se coincidir', isPasswordiqual),
                          _buildRequirementItem('Pelo menos 8 caracteres', isPasswordValidLength),
                          _buildRequirementItem('Pelo menos 1 número', isPasswordValidNumber),
                          _buildRequirementItem('Pelo menos 1 caractere especial', isPasswordValidSpecial),
                        ],
                      ),
                    ),

                  SizedBox(height: 15),

                  // Botão Criar Conta
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
                      onPressed: _registerUser,
                      child: Text(
                        "Criar conta",
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Link para voltar ao login
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, '/login');
                    },
                    child: Text(
                      "Já tem uma conta? Faça o login",
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
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

  Widget _buildTextField(
    String hint,
    TextEditingController controller,
    bool obscure,
    bool? isVisible,
    VoidCallback? toggleVisibility, {
    ValueChanged<String>? onChanged,
  }) {
    return SizedBox(
      width: 305,
      height: 40,
      child: TextField(
        controller: controller,
        obscureText: obscure && (isVisible == null || !isVisible),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
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
          suffixIcon: obscure
              ? GestureDetector(
                  onTap: toggleVisibility,
                  child: Icon(
                    isVisible! ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                )
              : null,
        ),
        style: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildRequirementItem(String text, bool met) {
    return Row(
      children: [
        Icon(
          met ? Icons.check_circle : Icons.circle_outlined,
          color: met ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 255, 255, 255),
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.outfit(
            fontSize: 12,
            color: met ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ],
    );
  }
}
