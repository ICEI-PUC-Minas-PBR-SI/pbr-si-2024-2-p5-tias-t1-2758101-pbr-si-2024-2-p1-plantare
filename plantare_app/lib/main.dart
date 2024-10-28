import 'package:flutter/material.dart';
import 'core/app_routes.dart';
import 'core/app_colors.dart';
import 'core/app_text_styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plantare App',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.light(
          secondary: AppColors.accent,
        ),
        textTheme: TextTheme(
          headlineLarge: AppTextStyles.title,
          titleMedium: AppTextStyles.subtitle,
          bodyLarge: AppTextStyles.body,
          labelLarge: AppTextStyles.buttonText,
        ),
      ),
      // Definindo as rotas usando AppRoutes
      initialRoute: AppRoutes.onboarding, // Rota inicial
      routes: AppRoutes.routes,
    );
  }
}
