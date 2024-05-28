import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Places {
  final String id;
  final String title;
  final File image;

  Places({required this.title, required this.image}) : id = uuid.v4();
}
