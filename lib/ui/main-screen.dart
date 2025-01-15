import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
              onPressed: () {},
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
