import 'package:flutter/material.dart';
import '../screens/onboarding_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/home_screen.dart';
import '../screens/planting_screen.dart';
import '../screens/report_screen.dart';
import '../screens/community_screen.dart';
import '../screens/comment_screen.dart';

class AppRoutes {
  static const String onboarding = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String planting = '/planting';
  static const String report = '/report';
  static const String community = '/community';
  static const String comment = '/comment';

  static final Map<String, WidgetBuilder> routes = {
    onboarding: (context) => OnboardingScreen(),
    login: (context) => LoginScreen(),
    register: (context) => RegisterScreen(),
    home: (context) => HomeScreen(),
    planting: (context) => PlantingScreen(),
    report: (context) => ReportScreen(),
    community: (context) => CommunityScreen(),
    comment: (context) => CommentScreen(),
  };
}
