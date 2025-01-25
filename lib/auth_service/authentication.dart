//import 'package:supabase_authentiation/auth_service/google_signin.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

//sign in with email and password

  Future<AuthResponse> signInWithEmailPassword(
      String email, String password) async {
    return await _supabase.auth
        .signInWithPassword(email: email, password: password);
  }

//sign up with email and password

  Future<AuthResponse> signUpWithEmailPassword(
      String email, String password) async {
    return await _supabase.auth.signUp(email: email, password: password);
  }

//sign out

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

//get current user email

  String? getCurrentuserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }

  // String webClientId =
  //     '1075514798882-9m89qd1lql4vci0hod3dqkhn596q4sn6.apps.googleusercontent.com';
  // String iosClientId =
  //     '1075514798882-lpug50o8jnt9h22d0chs8nlapa3fgpeb.apps.googleusercontent.com';

  Future<void> signInWithGoogle() async {
    /// TODO: update the Web client ID with your own.
    ///
    /// Web Client ID that you registered with Google Cloud.
    const webClientId =
        '1075514798882-9m89qd1lql4vci0hod3dqkhn596q4sn6.apps.googleusercontent.com';
    ;

    /// TODO: update the iOS client ID with your own.
    ///
    /// iOS Client ID that you registered with Google Cloud.
    const iosClientId =
        '1075514798882-lpug50o8jnt9h22d0chs8nlapa3fgpeb.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    await _supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }
}
