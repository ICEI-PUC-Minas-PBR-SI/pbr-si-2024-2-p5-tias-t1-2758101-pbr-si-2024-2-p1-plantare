import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Certifique-se de que o pacote está configurado corretamente
import '../core/app_routes.dart'; // Certifique-se de que AppRoutes está importado corretamente

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true; // Estado inicial das notificações

  // Função para enviar email
  Future<void> _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'contato@plantare.com',
      query: 'subject=Suporte ao Usuário&body=Por favor, descreva sua solicitação.',
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não foi possível abrir o cliente de email.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF04BB86), Color(0xFF225149)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/logo.png', // Substituir pelo caminho correto
                    height: 40,
                    width: 40,
                  ),
                  const Text(
                    "PLANTARE",
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Icon(Icons.search, color: Colors.white, size: 24),
                ],
              ),
            ),

            // Título "Configurações"
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.grey, size: 24),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "CONFIGURAÇÕES",
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Divider acima da caixa de informações
            _buildCustomDivider(),

            // Seção de informações do usuário
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(50.0), // Mais arredondado
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[300],
                    child: const Icon(Icons.person, size: 30, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Abner Amorim',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'abner@gmail.com',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.viewProfile); // Redireciona para ViewProfileScreen
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFBFBFBF),
                      ),
                      child: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                    ),
                  ),
                ],
              ),
            ),

            // Divisor customizado
            _buildCustomDivider(),

            // Seções "Conta" e "Preferências"
            _buildSectionTitle('Conta'),
            _buildOption(
              context,
              'Editar perfil',
              Icons.person,
              20,
              route: AppRoutes.editProfile, // Redireciona para EditProfileScreen
            ),
            _buildOption(
              context,
              'Segurança',
              Icons.lock,
              20,
              route: AppRoutes.securitySettings, // Redireciona para SecuritySettingsScreen
            ),
            _buildOption(
              context,
              'Termos de uso',
              Icons.description,
              20,
              route: AppRoutes.terms, // Redireciona para TermsScreen
            ),

            _buildCustomDivider(),

            _buildSectionTitle('Preferências'),
            _buildOptionSwitch(
              context,
              'Notificações',
              Icons.notifications,
              _notificationsEnabled,
            ),
            _buildOption(
              context,
              'Fale conosco',
              Icons.mail,
              20,
              onTap: _sendEmail, // Função para enviar email
            ),
            _buildOption(
              context,
              'Sair',
              Icons.exit_to_app,
              20,
              isLogout: true,
            ),
          ],
        ),
      ),
    );
  }

  // Divisor customizado
  Widget _buildCustomDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 5, // Altura ajustada
        color: const Color(0xFFBFBFBF),
      ),
    );
  }

  // Título de seção
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }

  // Opção de menu
  Widget _buildOption(BuildContext context, String title, IconData icon, double iconSize,
      {bool isLogout = false, String? route, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : const Color(0xFFBFBFBF), size: iconSize),
      title: Text(
        title,
        style: TextStyle(color: isLogout ? Colors.red : Colors.black),
      ),
      onTap: () {
        if (onTap != null) {
          onTap(); // Executa a função personalizada
        } else if (route != null) {
          Navigator.pushNamed(context, route); // Navega para a rota especificada
        }
      },
    );
  }

  // Opção com Switch e Ícone
  Widget _buildOptionSwitch(
      BuildContext context, String title, IconData icon, bool value) {
    return SwitchListTile(
      secondary: Icon(icon, color: const Color(0xFFBFBFBF), size: 20),
      title: Text(title, style: const TextStyle(color: Colors.black)),
      value: value,
      activeColor: Colors.green,
      onChanged: (bool newValue) {
        setState(() {
          _notificationsEnabled = newValue; // Atualiza o estado do switch
        });
      },
    );
  }
}