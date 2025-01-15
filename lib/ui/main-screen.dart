import 'package:flutter/material.dart';
import 'package:supabase_authentiation/auth_service/authentication.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final authService = AuthService();
  void logout() async {
    await authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Main Screen",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          ElevatedButton(
              onPressed: () {
                logout();
              },
              child: Icon(
                Icons.logout,
                color: Colors.blueGrey[600],
              ))
        ],
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}
