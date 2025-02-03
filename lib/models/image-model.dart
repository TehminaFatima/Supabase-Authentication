import 'dart:typed_data';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class ImageNote {
  @HiveField(0)
  final Uint8List imageBytes;

  @HiveField(1)
  final String note;

  ImageNote({required this.imageBytes, required this.note});
}
