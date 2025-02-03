import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../auth_service/authentication.dart';
import '../controllers/pop-up-container.dart';

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
        title: const Text("Main Screen", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: logout,
            icon: Icon(Icons.logout, color: Colors.white),
          ),
        ],
        backgroundColor: Colors.blueGrey,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _popUpContainer.toggleContainer,
        child: const Icon(Icons.keyboard_arrow_up_outlined),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: _popUpContainer.textList.length,
                    itemBuilder: (context, index) {
                      final item = _popUpContainer.textList[index];

                      return Card(
                        elevation: 4, // Elevation effect (shadow)
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          tileColor: Colors.blueGrey[100],
                          leading: Checkbox(
                            value: item['isChecked'],
                            onChanged: (_) =>
                                _popUpContainer.toggleCheck(index),
                          ),
                          title: Text(
                            item['text'],
                            style: TextStyle(
                              decoration: item['isChecked']
                                  ? TextDecoration
                                      .lineThrough // ✅ Strikethrough when checked
                                  : TextDecoration.none,
                            ),
                          ),
                          trailing: IconButton(
                            icon:
                                Icon(Icons.delete, color: Colors.blueGrey[600]),
                            onPressed: () {
                              _popUpContainer.deleteItem(index);
                            },
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
          Obx(() => _popUpContainer.showContainer.value
              ? Center(child: _buildContainer())
              : const SizedBox.shrink()),
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
