import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/app_text_styles.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.highlight,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Título e subtítulo
            Column(
              children: [
                Text(
                  'PLANTARE',
                  style: TextStyle(
                    fontFamily: 'Oswald', // Fonte Oswald para o título
                    fontSize: 60,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4), // Ajuste de espaçamento entre título e subtítulo
                Text(
                  'Cultive suas ideias',
                  style: TextStyle(
                    fontFamily: 'Manrope', // Fonte Manrope para o subtítulo
                    fontSize: 18,
                    fontWeight: FontWeight.w700, // Negrito para o subtítulo
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24), // Espaçamento entre texto e imagem
            // Imagem de ilustração
            Image.asset(
              'assets/images/onboarding_image.png',
              height: 380, // Ajuste de altura da imagem para balancear o layout
            ),
            SizedBox(height: 40), // Espaçamento entre imagem e botões
            // Botão "Entrar"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  minimumSize: Size(double.infinity, 48),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  'Entrar',
                  style: TextStyle(
                    fontFamily: 'Manrope', // Fonte Manrope para o botão
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8), // Espaçamento entre os botões
            // Botão "Cadastre-se"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  minimumSize: Size(double.infinity, 48),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text(
                  'Cadastre-se',
                  style: TextStyle(
                    fontFamily: 'Manrope', // Fonte Manrope para o botão
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ),
            ),
            SizedBox(height: 32), // Espaçamento antes da versão
            // Texto "Versão 1.0"
            Text(
              'Versão 1.0',
              style: TextStyle(
                fontFamily: 'Manrope', // Fonte Manrope para o texto da versão
                fontSize: 12,
                color: AppColors.textDark,
              ),
            ),
            SizedBox(height: 16), // Espaçamento final para centralizar na tela
          ],
        ),
      ),
    );
  }
}
