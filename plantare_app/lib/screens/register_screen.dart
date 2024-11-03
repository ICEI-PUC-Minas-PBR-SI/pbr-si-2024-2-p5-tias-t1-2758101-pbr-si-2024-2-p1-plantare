import 'package:flutter/material.dart';
import 'package:plantare_app/database/database_helper.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirestoreService firestoreService = FirestoreService();

  // Controladores de texto para capturar valores dos campos
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isCheckboxChecked = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isPasswordValidLength = false;
  bool isPasswordValidNumber = false;
  bool isPasswordValidSpecial = false;
  String password = '';
  String confirmPassword = '';
  bool passwordsMatch = true;

  void _validatePassword(String value) {
    setState(() {
      isPasswordValidLength = value.length >= 8;
      isPasswordValidNumber = value.contains(RegExp(r'[0-9]'));
      isPasswordValidSpecial = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      password = value;
      passwordsMatch = password == confirmPassword;
    });
  }

  void _validateConfirmPassword(String value) {
    setState(() {
      confirmPassword = value;
      passwordsMatch = password == confirmPassword;
    });
  }

  @override
  void dispose() {
    // Libere os controladores quando a tela for descartada para evitar vazamentos de memória
    nomeController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.highlight,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Crie sua conta',
              style: TextStyle(
                fontFamily: 'Oswald',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 24),

            // Campo Nome com controlador
            TextField(
              controller: nomeController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Insira seu nome',
                hintStyle: TextStyle(
                  fontFamily: 'Manrope',
                  color: Color.fromARGB(255, 175, 171, 171),
                ),
                prefixIcon: Icon(Icons.person, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Campo E-mail com controlador
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Seu melhor e-mail',
                hintStyle: TextStyle(
                  fontFamily: 'Manrope',
                  color: Color.fromARGB(255, 176, 171, 171),
                ),
                prefixIcon: Icon(Icons.email, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Campo Senha com controlador
            TextField(
              controller: passwordController,
              obscureText: !isPasswordVisible,
              onChanged: _validatePassword,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Insira sua senha',
                hintStyle: TextStyle(
                  fontFamily: 'Manrope',
                  color: Color.fromARGB(255, 185, 180, 180),
                ),
                prefixIcon: Icon(Icons.lock, color: Colors.black),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Campo Confirmar Senha
            TextField(
              obscureText: !isConfirmPasswordVisible,
              onChanged: _validateConfirmPassword,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Confirme sua senha',
                hintStyle: TextStyle(
                  fontFamily: 'Manrope',
                  color: Color.fromARGB(255, 185, 180, 180),
                ),
                prefixIcon: Icon(Icons.lock, color: Colors.black),
                suffixIcon: IconButton(
                  icon: Icon(
                    isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      isConfirmPasswordVisible = !isConfirmPasswordVisible;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            if (!passwordsMatch)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'As senhas devem ser idênticas',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
            SizedBox(height: 16),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRequirementItem('Pelo menos 8 caracteres', isPasswordValidLength),
                _buildRequirementItem('Pelo menos 1 número', isPasswordValidNumber),
                _buildRequirementItem('1 caractere especial', isPasswordValidSpecial),
              ],
            ),
            SizedBox(height: 16),

            Row(
              children: [
                Theme(
                  data: ThemeData(
                    unselectedWidgetColor: Colors.black,
                  ),
                  child: Checkbox(
                    value: isCheckboxChecked,
                    onChanged: (value) {
                      setState(() {
                        isCheckboxChecked = value!;
                      });
                    },
                    checkColor: Colors.black,
                    fillColor: MaterialStateProperty.all(Colors.white),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Ao criar sua conta, você concorda com nossos Termos de Uso e Política de Privacidade.',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Botão "Crie sua conta"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  minimumSize: Size(double.infinity, 48),
                ),
                onPressed: () {
                  if (isCheckboxChecked &&
                      passwordsMatch &&
                      isPasswordValidLength &&
                      isPasswordValidNumber &&
                      isPasswordValidSpecial) {
                    // Acessa os valores dos campos usando os controladores
                    String nome = nomeController.text;
                    String email = emailController.text;
                    String senha = passwordController.text;

                    firestoreService.registerUser(nome, email, senha);
                    Navigator.pushNamed(context, '/home');
                  }
                },
                child: Text(
                  'Crie sua conta',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirementItem(String text, bool met) {
    return Row(
      children: [
        Icon(
          met ? Icons.check_circle : Icons.circle,
          color: met ? Color(0xFF5D2B20) : Colors.black,
          size: 16,
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'Manrope',
            color: met ? Color(0xFF5D2B20) : Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
