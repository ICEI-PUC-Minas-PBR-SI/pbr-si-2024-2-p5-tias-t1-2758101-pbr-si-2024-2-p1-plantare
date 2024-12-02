import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Cor de fundo ajustada ao modelo
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF04BB86), Color(0xFF225149)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/logo.png', // Substituir pelo caminho correto da logo
                    height: 40,
                    width: 40,
                  ),
                  Text(
                    "PLANTARE",
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Icon(Icons.search, color: Colors.white),
                ],
              ),
            ),

            // Título "Perfil"
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.grey),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "PERFIL",
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 255, 255, 255),
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
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0x00BFBFBF),
                borderRadius: BorderRadius.circular(24.0), // Ajustado
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.person, size: 30, color: Colors.white),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFBFBFBF),
                    ),
                    child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                  ),
                ],
              ),
            ),

            // Divisor customizado
            _buildCustomDivider(),

            // Seções "Conta" e "Preferências"
            _buildSectionTitle('Conta'),
            _buildOption(context, 'Editar perfil', Icons.person),
            _buildOption(context, 'Segurança', Icons.lock),
            _buildOption(context, 'Termos de uso', Icons.description),

            _buildCustomDivider(),

            _buildSectionTitle('Preferências'),
            _buildOptionSwitch(context, 'Notificações', Icons.notifications, true),
            _buildOption(context, 'Fale conosco', Icons.mail),
            _buildOption(
              context,
              'Sair',
              Icons.exit_to_app,
              isLogout: true,
            ),
          ],
        ),
      ),

      // Botão central no menu inferior
      bottomNavigationBar: Stack(
        children: [
          BottomAppBar(
            color: Colors.black, // Cor ajustada
            shape: CircularNotchedRectangle(),
            notchMargin: 8.0,
            child: Container(
              height: 60.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.home, color: Color(0xFFBFBFBF)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.people, color: Color(0xFFBFBFBF)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/community');
                    },
                  ),
                  SizedBox(width: 40), // Espaço para o botão central
                  IconButton(
                    icon: Icon(Icons.analytics, color: Color(0xFFBFBFBF)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/report');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.person, color: Color(0xFFBFBFBF)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            left: MediaQuery.of(context).size.width / 2 - 28,
            child: Container(
              height: 60.0,
              width: 60.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF04BB86), Color(0xFF225149)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3), // Sombra suave
                  ),
                ],
              ),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/planting');
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Icon(Icons.add, color: Colors.white, size: 28),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Divisor customizado
  Widget _buildCustomDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 5, // Altura ajustada
        color: Color(0xFFBFBFBF),
      ),
    );
  }

  // Título de seção
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white, // Cor ajustada
        ),
      ),
    );
  }

  // Opção de menu
  Widget _buildOption(BuildContext context, String title, IconData icon,
      {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Color(0xFFBFBFBF)),
      title: Text(
        title,
        style: TextStyle(color: isLogout ? Colors.red : Colors.white),
      ),
      onTap: () {
        if (isLogout) {
          // Lógica para logout
        }
      },
    );
  }

  // Opção com Switch e Ícone
  Widget _buildOptionSwitch(
      BuildContext context, String title, IconData icon, bool value) {
    return SwitchListTile(
      secondary: Icon(icon, color: Color(0xFFBFBFBF)),
      title: Text(title, style: TextStyle(color: Colors.white)),
      value: value,
      activeColor: Colors.green,
      onChanged: (bool newValue) {
        // Lógica para alternar o switch
      },
    );
  }
}