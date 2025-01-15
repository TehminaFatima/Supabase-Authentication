import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_authentiation/ui/sign-in-screen.dart';
import 'package:supabase_authentiation/ui/sign-up-screen.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome Screen",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Container(
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
          width: Get.width / 1.12,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    //maximumSize: Size(300, 50), // Adjust the size as needed
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
                    Get.to(SignUpScreen());
                  },
                  child: Text('SignUp'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
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
                    Get.to(SignInScreen());
                  },
                  child: Text('SignIn'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
