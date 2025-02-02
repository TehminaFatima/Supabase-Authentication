import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_authentiation/auth_service/authentication.dart'; // Ensure this import is correct

class PopUpContainer extends GetxController {
  var showContainer = false.obs;
  var textList = <String>[].obs;

  void toggleContainer() {
    showContainer.value = !showContainer.value;
  }

  void clear() {
    textList.clear();
  }

  void addText(String text) {
    if (text.isNotEmpty) {
      textList.add(text);
    }
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final authService = AuthService();
  final PopUpContainer _popUpContainer = Get.put(PopUpContainer());
  final TextEditingController _textController = TextEditingController();

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
      body: Stack(
        children: [
          // Main content
          Column(
            children: [
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: _popUpContainer.textList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_popUpContainer.textList[index]),
                      );
                    },
                  );
                }),
              ),
            ],
          ),

          // Popup Container
          Obx(() {
            if (_popUpContainer.showContainer.value) {
              return Center(
                child: _buildContainer(),
              );
            } else {
              return const SizedBox.shrink(); // Hide the container
            }
          }),
        ],
      ),
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
          TextField(
            controller: _textController,
            decoration: const InputDecoration(
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
                  // Add text to the list
                  _popUpContainer.addText(_textController.text);
                  // Clear the text field
                  _textController.clear();
                  // Close the container
                  _popUpContainer.toggleContainer();
                },
                child: const Text("Add"),
              ),
              ElevatedButton(
                onPressed: () {
                  // Close the container without adding text
                  _popUpContainer.toggleContainer();
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
