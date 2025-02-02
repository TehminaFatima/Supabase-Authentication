import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_authentiation/auth_service/authentication.dart'; // Ensure this import is correct

class PopUpContainer extends GetxController {
  var showContainer = false.obs;

  void toggleContainer() {
    showContainer.value = !showContainer.value;
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final authService = AuthService();
  final PopUpContainer _popUpContainer =
      Get.put(PopUpContainer()); // Initialize the controller

  void logout() async {
    await authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Main Screen",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: logout,
            icon: Icon(
              Icons.logout,
              color: Colors.blueGrey[600],
            ),
          ),
        ],
        backgroundColor: Colors.blueGrey,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _popUpContainer.toggleContainer(); // Toggle the container visibility
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        return Stack(
          children: [
            // Main content
            const Center(
              child: Text('Press the FAB to see the container!'),
            ),

            // Popup Container
            if (_popUpContainer.showContainer.value)
              Center(
                child: _buildContainer(),
              ),
          ],
        );
      }),
    );
  }

  Widget _buildContainer() {
    return Container(
      height: 200,
      width: 400,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueGrey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextField(
            decoration: InputDecoration(
              labelText: 'Enter something',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Add functionality here
                },
                child: const Text("Add"),
              ),
              ElevatedButton(
                onPressed: () {
                  _popUpContainer.toggleContainer(); // Close the container
                },
                child: const Text("Cancel"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
