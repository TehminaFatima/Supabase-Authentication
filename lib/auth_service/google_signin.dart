import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignin {
  final SupabaseClient supabase = Supabase.instance.client;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    try {
      // Perform Google sign-in
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) return; // User canceled the sign-in

      final GoogleSignInAuthentication auth = await account.authentication;

      // Exchange Google ID token with Supabase
      final response = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: auth.idToken!,
        accessToken: auth.accessToken,
      );

      if (response.error == null) {
        print('Logged in as ${response.user?.email}');
      } else {
        print('Error: ${response.error!.message}');
      }
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
    await _googleSignIn.signOut();
  }
}
