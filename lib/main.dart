import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:toguishi/screens/authenticated/home_screen.dart';
import 'package:toguishi/screens/unauthenticated/login_screen.dart';

void main() async {
  final configProvider = ConfigProvider();
  await configProvider.loadConfig();
  runApp(
    ChangeNotifierProvider.value(
      value: configProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toguishi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthWrapper(),
    );
  }
}

class ConfigProvider extends ChangeNotifier {
  late String ip;

  Future<void> loadConfig() async {
    await dotenv.load();
    ip = dotenv.env['PUBLIC_IP_ADDRESS'] ?? '';
    notifyListeners();
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    bool isAuthenticated = false;
    return isAuthenticated ? HomeScreen() : LoginScreen();
  }
}
