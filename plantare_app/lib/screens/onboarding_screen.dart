import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 390, // Largura fixa do layout
          height: 844, // Altura fixa do layout
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0), // Ajuste de padding interno
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF04BB86), // Cor inicial do degradê
                  Color(0xFF225149), // Cor final do degradê
                ],
                begin: Alignment.topCenter, // Degradê começa no topo
                end: Alignment.bottomCenter, // Degradê termina na parte inferior
              ),
              borderRadius: BorderRadius.circular(50), // Arredondamento nas bordas
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espaçamento entre os elementos principais
              children: [
                // Espaço entre o topo e os textos
                Padding(
                  padding: EdgeInsets.only(top: 30.0), // Espaçamento interno no topo
                  child: Column(
                    children: [
                      // Título com fonte Outfit
                      Text(
                        'PLANTARE',
                        style: GoogleFonts.outfit(
                          fontSize: 64, // Ajuste do tamanho
                          fontWeight: FontWeight.w600, // Peso da fonte
                          letterSpacing: 1,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 0), // Espaçamento entre título e subtítulo
                      // Subtítulo com fonte Outfit
                      Text(
                        'Cultive suas ideias',
                        style: GoogleFonts.outfit(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15), // Espaçamento entre texto e imagem
                // Imagem com tamanho ajustado
                SizedBox(
                  width: 450, // Largura ajustada
                  height: 350, // Altura ajustada
                  child: Image.asset(
                    'assets/images/onboarding_image.png',
                    fit: BoxFit.contain, // Mantém a proporção da imagem
                  ),
                ),
                Column(
                  children: [
                    // Botão "Entrar" com fonte Outfit
                    SizedBox(
                      width: 240, // Largura fixa
                      height: 40, // Altura fixa
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50), // Arredondamento no botão
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text(
                          'Entrar',
                          style: GoogleFonts.outfit(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20), // Espaçamento entre os botões
                    // Botão "Cadastre-se" com fonte Outfit
                    SizedBox(
                      width: 240, // Largura fixa
                      height: 40, // Altura fixa
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50), // Arredondamento no botão
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text(
                          'Cadastre-se',
                          style: GoogleFonts.outfit(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20), // Espaçamento entre botões e rodapé
                // Versão no rodapé com fonte Outfit
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Versão 2.0',
                    style: GoogleFonts.outfit(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
