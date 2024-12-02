import 'package:flutter/material.dart';
import '../screens/onboarding_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart'; // Importação correta
import '../screens/forgot_password.dart'; // Importação correta
import '../screens/home_screen.dart';
import '../screens/planting_screen.dart';
import '../screens/report_screen.dart';
import '../screens/community_screen.dart';
import '../screens/comment_screen.dart';
<<<<<<< HEAD
import '../screens/profile.dart';

=======
import '../screens/profile_screen.dart';  // Importando a tela de perfil
>>>>>>> 9fa6058 (Alterações na tela HomeScreen, novas rotas e adição da tela de perfil)

class AppRoutes {
  static const String onboarding = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotpassword = '/forgotpassword';
  static const String home = '/home';
  static const String planting = '/planting';
  static const String report = '/report';
  static const String community = '/community';
  static const String comment = '/comment';
<<<<<<< HEAD
  static const String profile = '/profile';
=======
  static const String profile = '/profile';  // Adicionando a constante de rota para perfil
>>>>>>> 9fa6058 (Alterações na tela HomeScreen, novas rotas e adição da tela de perfil)

  static final Map<String, WidgetBuilder> routes = {
    onboarding: (context) => OnboardingScreen(),
    login: (context) => LoginScreen(),
    register: (context) => RegisterScreen(),
    forgotpassword: (context) => ForgotPassword(),
    home: (context) => HomeScreen(),
    planting: (context) => PlantingScreen(),
    report: (context) => ReportScreen(),
    community: (context) => CommunityScreen(),
    comment: (context) => CommentScreen(),
<<<<<<< HEAD
    profile: (context) => ProfileScreen(),
=======
    profile: (context) => ProfileScreen(),  // Registrando a tela de perfil
>>>>>>> 9fa6058 (Alterações na tela HomeScreen, novas rotas e adição da tela de perfil)
  };
}
