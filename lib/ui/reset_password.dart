import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _emailcontroller = TextEditingController();
  final _newPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reset Password",
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
              padding: EdgeInsets.only(top: 130),
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
                  children: [
                    Container(
                        height: Get.height / 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueGrey[100],
                        ),
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _emailcontroller,
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
                          controller: _newPasswordController,
                          decoration: InputDecoration(
                            hintText: "Enter New Password",
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
                      },
                      child: Text('Reset Your Password'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
