import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toguishi/screens/unauthenticated/login_screen.dart';
import 'package:toguishi/state/auth_provider.dart';
import 'package:toguishi/state/config_provider.dart';
import 'package:toguishi/state/storage_service.dart';
import 'package:toguishi/widgets/nav/bottom_nav.dart';

void main() async {
  final configProvider = ConfigProvider();
  await configProvider.loadConfig();

  final authProvider = AuthProvider();
  await authProvider.checkAuthentication();

  final storageService = StorageService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: configProvider,
        ),
        ChangeNotifierProvider.value(value: authProvider),
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

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthProvider>(context);
    return authState.isAuthenticated ? const Bottomnav() : const LoginScreen();
  }
}
