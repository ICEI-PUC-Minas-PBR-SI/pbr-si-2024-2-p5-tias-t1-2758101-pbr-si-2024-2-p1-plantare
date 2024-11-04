import 'package:flutter/material.dart';
import 'core/app_routes.dart';
import 'core/app_colors.dart';
import 'core/app_text_styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'database/database_helper.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   try{
    await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDaoAbYq7CmXjEI5TZRPI2_jz0w2-jGBi8",
      authDomain: "plantare-app.firebaseapp.com",
      projectId: "plantare-app",
      storageBucket: "plantare-app.firebasestorage.app",
      messagingSenderId: "468361004286",
      appId: "1:468361004286:web:9806e72a37ed4bceb0d1af",
    ),
  );
  print("Firebase inicializado com sucesso");
   }
   catch (e) {
    print("Erro ao inicializar Firebase: $e");
  }
  
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