import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_authentiation/auth_service/authentication.dart';
import '../controllers/pop-up-container.dart';
import '../controllers/slideable-widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final authService = AuthService();
  final PopUpContainer _popUpContainer = Get.put(PopUpContainer());
  final ExpandableMenuController menuController =
      Get.put(ExpandableMenuController());
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void logout() async => await authService.signOut();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Screen", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
        ],
        backgroundColor: Colors.blueGrey,
      ),
      floatingActionButton: _buildExpandableFAB(),
      body: Stack(
        children: [
          _buildMainContent(),
          Obx(() => _popUpContainer.showContainer.value
              ? _buildInputContainer()
              : const SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget _buildExpandableFAB() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Obx(() => AnimatedOpacity(
              opacity: menuController.isExpanded.value ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _fabButton(
                      Icons.add, "Add Note", _popUpContainer.toggleContainer),
                  _fabButton(Icons.add_a_photo, "Gallery", () {}),
                  _fabButton(Icons.camera, "Camera", () {}),
                  _fabButton(Icons.mic, "Mic", () {}),
                ]
                    .map((w) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: w,
                        ))
                    .toList(),
              ),
            )),
        Obx(() => FloatingActionButton(
              onPressed: menuController.toggleMenu,
              backgroundColor: Colors.blueGrey,
              child: AnimatedRotation(
                duration: const Duration(milliseconds: 300),
                turns: menuController.isExpanded.value ? 0.5 : 0,
                child: const Icon(Icons.keyboard_arrow_up, color: Colors.white),
              ),
            )),
      ],
    );
  }

  Widget _fabButton(IconData icon, String heroTag, VoidCallback onPressed) {
    return FloatingActionButton(
      heroTag: heroTag,
      onPressed: () {
        onPressed();
        menuController.toggleMenu();
      },
      backgroundColor: Colors.blueGrey,
      mini: true,
      child: Icon(icon),
    );
  }

  Widget _buildMainContent() {
    return Obx(() => ListView.builder(
          itemCount: _popUpContainer.textList.length,
          itemBuilder: (context, index) => _listItem(index),
        ));
  }

  Widget _listItem(int index) {
    final item = _popUpContainer.textList[index];
    return Dismissible(
      key: Key(item['text']),
      background: Container(color: Colors.red),
      confirmDismiss: (_) => _confirmDelete(index),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListTile(
          leading: Checkbox(
            value: item['isChecked'],
            onChanged: (_) => _popUpContainer.toggleCheck(index),
          ),
          title: Text(
            item['text'],
            style: TextStyle(
              decoration: item['isChecked']
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.blueGrey),
            onPressed: () => _confirmDelete(index),
          ),
        ),
      ),
    );
  }

  Future<bool?> _confirmDelete(int index) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this item?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              _popUpContainer.deleteItem(index);
              Navigator.pop(context, true);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildInputContainer() {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _textController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Enter note',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _actionButton("Cancel", Colors.grey,
                      () => _popUpContainer.toggleContainer()),
                  _actionButton("Add", Colors.blue, () {
                    if (_textController.text.isNotEmpty) {
                      _popUpContainer.addText(_textController.text);
                      _textController.clear();
                      _popUpContainer.toggleContainer();
                    }
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
