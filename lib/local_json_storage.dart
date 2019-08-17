import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalJsonStorage {
  Future<dynamic> getJson(String filename) async {
    var file = await _getFile(filename);
    if (await file.exists()) {
      return jsonDecode(await file.readAsString());
    } else {
      return null;
    }
  }

  Future<File> saveJson(String filename, Object object) async {
    var file = await _getFile(filename);
    return file.writeAsString(jsonEncode(object));
  }

  Future<File> _getFile(String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$filename');
  }
}
