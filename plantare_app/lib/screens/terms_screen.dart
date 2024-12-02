import 'package:flutter/material.dart';
import '../core/app_routes.dart';

class TermsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Termos de Uso"),
        backgroundColor: const Color(0xFF04BB86),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: SingleChildScrollView(
                child: Text(
                  """
Termos de Uso

Bem-vindo ao Plantare!

Ao usar este aplicativo, você concorda com os seguintes termos:

1. Uso Responsável:
   Você concorda em usar o aplicativo de forma ética, sem comprometer sua funcionalidade ou integridade.

2. Coleta de Dados:
   O Plantare pode coletar informações para melhorar a experiência do usuário. Sua privacidade será sempre respeitada.

3. Limitações:
   Não somos responsáveis por qualquer perda ou dano causado pelo uso indevido do aplicativo.

4. Alterações:
   Os termos podem ser alterados a qualquer momento. É sua responsabilidade revisá-los regularmente.

Ao continuar, você aceita nossos termos e condições.
                  """,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Ação ao recusar os termos
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Você recusou os termos de uso.'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Recusar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Ação ao aceitar os termos
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Você aceitou os termos de uso.'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF04BB86),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Aceitar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}