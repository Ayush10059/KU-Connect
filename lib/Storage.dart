import 'package:path_provider/path_provider.dart';
import 'dart:io';

Map<String, String> headers = {"Content-type": "application/json"};

class Storage {
  String fileName = '';
  Storage(String fName) {
    fileName=fName;
  }

  //get directory in device
  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  //get file in directory
  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/$fileName');
  }

  //funtion to read data from file
  Future<String> readData() async {
    try {
      final file = await localFile;
      String body = await file.readAsString();
      return body;
    } catch (e) {
      return "error";
    }
  }

  //function to write data to file
  Future<File> writeData(String data) async {
    final file = await localFile;
    return file.writeAsString("$data");
  }
}