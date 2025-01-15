import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:supabase_authentiation/ui/main-screen.dart';
import 'package:supabase_authentiation/ui/sign-in-screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // Handle stream error
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'An error occurred. Please try again later.',
                    style: TextStyle(color: Colors.red),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Retry logic, e.g., restarting the stream or navigating to an error page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AuthGate()),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        try {
          final session = snapshot.hasData ? snapshot.data?.session : null;

          if (session != null) {
            // User is logged in
            return MainScreen();
          } else {
            // User is not logged in
            return SignInScreen();
          }
        } catch (e) {
          // Handle unexpected errors
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Unexpected error occurred.',
                    style: TextStyle(color: Colors.red),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Retry logic or navigate to sign-in
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AuthGate()),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
