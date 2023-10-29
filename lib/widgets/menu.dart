import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toguishi/state/auth_provider.dart';
import 'package:toguishi/state/storage_service.dart';

class Menu extends StatelessWidget {
  void _handleLogout(BuildContext context) {
    final storageService = Provider.of<StorageService>(context, listen: false);
    storageService.delete('token');
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.checkAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.menu),
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem(
            value: 'sair',
            child: Text('Sair'),
          ),
        ];
      },
      onSelected: (value) {
        if (value == 'sair') {
          _handleLogout(context);
        }
      },
    );
  }
}
