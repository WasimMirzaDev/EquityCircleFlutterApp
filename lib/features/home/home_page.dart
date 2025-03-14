import 'package:equitycircle/core/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (!authProvider.isAuthenticated) {
      return Center(child: Text("Not Logged In"));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          authProvider.isAuthenticated
              ? "Welcome, ${authProvider.userData?['name']}"
              : "Not Logged In",
        ),
      ),
      body: Center(child: Text('Home Page')),
    );
  }
}
