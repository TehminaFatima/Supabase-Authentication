import 'package:flutter/material.dart';
import 'package:supabase_authentiation/auth_service/auth_gate.dart';
import 'package:supabase_authentiation/ui/screen1.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://gdhhujsvqjcgbuqdcrvu.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdkaGh1anN2cWpjZ2J1cWRjcnZ1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY5NjQyOTIsImV4cCI6MjA1MjU0MDI5Mn0.DynyQasCUAxXA6i_SVK8DyuOV4zb8ynWBKEfIQF0T8w',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
