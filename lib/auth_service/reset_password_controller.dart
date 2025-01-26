import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResetPasswordController extends GetxController {
  // Observables for the state
  var isLoading = false.obs;
  var errorMessage = Rxn<String>();

  // Reset password logic
  Future<void> resetPassword(String email) async {
    if (email.isEmpty) {
      errorMessage.value = 'Please enter your email';
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    try {
      final response =
          await Supabase.instance.client.auth.resetPasswordForEmail(email);

      // if (response.error != null) {
      //   errorMessage.value = response.error?.message;
      // } else {
      //   // Password reset email sent successfully
      //   Get.snackbar('Success', 'Password reset email sent');
      // }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
