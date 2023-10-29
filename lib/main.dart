import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:toguishi/screens/authenticated/home_screen.dart';
import 'package:toguishi/screens/unauthenticated/login_screen.dart';
import 'package:toguishi/services/storage_service.dart';

void main() async {
  final configProvider = ConfigProvider();
  await configProvider.loadConfig();

  final authState = AuthState();
  await authState.checkAuthentication();

  final storageService = StorageService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: configProvider,
        ),
        ChangeNotifierProvider.value(value: authState),
        Provider.value(value: storageService),
      ],
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

class AuthState extends ChangeNotifier {
  bool isAuthenticated = false;

  Future<void> checkAuthentication() async {
    try {
      final token = await StorageService().read('token');
      print(token);
      isAuthenticated = token != null;
      print("Called");
      notifyListeners();
    } catch (e) {
      isAuthenticated = false;
      notifyListeners();
    }
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context);
    return authState.isAuthenticated ? const HomeScreen() : const LoginScreen();
  }
}
