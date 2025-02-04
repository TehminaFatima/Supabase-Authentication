import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

import '../models/image-model.dart';

class ImageNoteController extends GetxController {
  final Box imageNotesBox = Hive.box('imageNotesBox');
  final Rx<Uint8List?> capturedImage = Rx<Uint8List?>(null);
  final TextEditingController noteController = TextEditingController();

  Future<void> captureImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.camera);

    if (imageFile != null) {
      final File file = File(imageFile.path);
      final Uint8List imageBytes = await file.readAsBytes();
      capturedImage.value = imageBytes;
    }
  }

  void saveImageNote() {
    if (capturedImage.value != null && noteController.text.isNotEmpty) {
      final imageNote = ImageNote(
        imageBytes: capturedImage.value!,
        note: noteController.text,
      );
      imageNotesBox.add(imageNote); // Save to Hive
      capturedImage.value = null; // Clear the captured image
      noteController.clear(); // Clear the note text field
    }
  }

  List<ImageNote> getImageNotes() {
    return imageNotesBox.values.toList().cast<ImageNote>();
  }
}
