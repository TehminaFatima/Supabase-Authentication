import 'package:get/get.dart';
import 'package:hive/hive.dart';

class PopUpContainer extends GetxService {
  var showContainer = false.obs;
  late Box<Map<dynamic, dynamic>> textBox; // Storing text and checkbox state
  var textList = <Map<String, dynamic>>[].obs; // Ensure this is a list of maps

  @override
  Future<void> onInit() async {
    super.onInit();
    await _initializeHive();
  }

  Future<void> _initializeHive() async {
    textBox = await Hive.openBox<Map<dynamic, dynamic>>('textMapList');

    // Convert Hive-stored data into a list of maps
    textList.assignAll(textBox.values
        .map((item) => {
              'text': item['text'] as String,
              'isChecked': item['isChecked'] as bool,
            })
        .toList());
  }

  void toggleContainer() {
    showContainer.value = !showContainer.value;
  }

  void clear() {
    textBox.clear();
    textList.clear();
  }

  void addText(String text) {
    if (text.isNotEmpty) {
      final newItem = {'text': text, 'isChecked': false};

      // Save to Hive and update list
      textBox.add(newItem);
      textList.add(newItem);
    }
  }

  void toggleCheck(int index) {
    textList[index] = {
      'text': textList[index]['text'],
      'isChecked': !textList[index]['isChecked'], // Toggle checkbox state
    };

    textBox.putAt(index, textList[index]); // Update Hive
    textList.refresh(); // Notify UI of changes
  }

  void deleteItem(int index) {
    textBox.deleteAt(index); // Remove from Hive
    textList.removeAt(index); // Remove from UI list
  }
}
