import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toguishi/state/auth_provider.dart';
import 'package:toguishi/state/storage_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _handleLogout(BuildContext context) {
    final storageService = Provider.of<StorageService>(context, listen: false);
    storageService.delete('token');
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.checkAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => _handleLogout(context),
          ),
        ],
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Welcome to the Home Screen'),
        ),
      ),
    );
  }
}
