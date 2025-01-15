import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _Screen1State();
}

class _Screen1State extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign Up Screen",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: Get.height / 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueGrey[100],
                      ),
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter Your Name",
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
                        decoration: InputDecoration(
                          hintText: "Enter Your Password",
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
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(color: Colors.blueGrey[800]),
                          border: InputBorder.none,
                        ),
                      )),
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
                      print('Button Pressed!');
                    },
                    child: Text('Click Me'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
