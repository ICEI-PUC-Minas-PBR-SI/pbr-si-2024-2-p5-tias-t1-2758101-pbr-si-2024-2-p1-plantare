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
import '../screens/settings_screen.dart';  // Tela de configurações
import '../screens/edit_profile_screen.dart';  // Tela de edição de perfil
import '../screens/view_profile_screen.dart'; // Tela de visualização do perfil
import '../screens/security_settings_screen.dart'; // Tela de configurações de segurança
import '../screens/terms_screen.dart'; // Importar a tela

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
  static const String settings = '/settings'; // Tela de configurações (antiga ProfileScreen)
  static const String editProfile = '/edit-profile'; // Tela de edição de perfil
  static const String viewProfile = '/view-profile'; // Tela de visualização de perfil
  static const String securitySettings = '/security-settings'; // Tela de configurações de segurança
  static const String terms = '/terms'; // Rota para termos de uso

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
    settings: (context) => SettingsScreen(), // Tela de configurações
    editProfile: (context) => EditProfileScreen(), // Tela de edição de perfil
    viewProfile: (context) => ViewProfileScreen(), // Tela de visualização de perfil
    securitySettings: (context) => SecuritySettingsScreen(), // Tela de configurações de segurança
    terms: (context) => TermsScreen(), // Tela de Termos de Uso
  };
}
