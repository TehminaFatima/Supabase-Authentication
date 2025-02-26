import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_authentiation/auth_service/authentication.dart';
import 'package:supabase_authentiation/ui/main-screen.dart';
import 'package:supabase_authentiation/ui/reset_password.dart';
import 'package:supabase_authentiation/ui/sign-up-screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInState();
}

class _SignInState extends State<SignInScreen> {
  final authService = AuthService();
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  void signin() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      await authService.signInWithEmailPassword(email, password);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainScreen()));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text(
          "SignIn Screen",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 40.0,
            ),
            child: Container(
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ]),
              height: Get.height / 1.5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        height: Get.height / 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueGrey[100],
                        ),
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: "Enter Your Email Address",
                            hintStyle: TextStyle(color: Colors.blueGrey[800]),
                            border: InputBorder.none,
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: Get.height / 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueGrey[100],
                        ),
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: "Enter Your Password",
                            hintStyle: TextStyle(color: Colors.blueGrey[800]),
                            border: InputBorder.none,
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => ResetPassword());
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 190),
                        child: Text("forget Password?"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // Circular border
                        ),
                        backgroundColor: Colors.blueGrey[500],
                        foregroundColor: Colors.white, // Custom button color
                        // Text color
                        elevation: 5.0, // Shadow elevation
                      ),
                      onPressed: () {
                        // Define your action here
                        signin();
                      },
                      child: Text('SignIn'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Don't have an account ?"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()));
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.blueGrey[800]),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.26,
              top: MediaQuery.of(context).size.width * 0.1,
            ),
            child: GestureDetector(
              onTap: () => authService.signInWithGoogle(),
              child: Row(
                children: [
                  Image(
                    height: 20,
                    image: AssetImage("assets/Gicon.png"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Sign In with Google",
                    style: TextStyle(color: Colors.blueGrey[700]),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
