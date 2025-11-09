import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/character_model.dart';
import 'controllers/character_controller.dart';
import 'controllers/favorites_controller.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await _initHive();

  // Register Hive adapters
  Hive.registerAdapter(CharacterAdapter());

  // Initialize controllers
  Get.put(CharacterController());
  Get.put(FavoritesController());

  runApp(const MyApp());
}

Future<void> _initHive() async {
  try {
    await Hive.initFlutter();
  } catch (e) {
    print('Error initializing Hive: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rick and Morty',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
