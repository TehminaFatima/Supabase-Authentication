import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:supabase_authentiation/auth_service/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter is initialized

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://gdhhujsvqjcgbuqdcrvu.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdkaGh1anN2cWpjZ2J1cWRjcnZ1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY5NjQyOTIsImV4cCI6MjA1MjU0MDI5Mn0.DynyQasCUAxXA6i_SVK8DyuOV4zb8ynWBKEfIQF0T8w',
  );

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(ImageNoteAdapter()); // Register the adapter

  await Future.wait([
    Hive.openBox<String>('textList'),
    Hive.openBox<bool>('checkList'),
    Hive.openBox('imageNotesBox')
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
