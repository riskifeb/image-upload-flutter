import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(KifebApp());

class KifebApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  downloadfile();
                },
                child: const Text('Upload'))
          ],
        )),
      ),
    );
  }
}

Future downloadfile() async {
  var dio = Dio();

  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    File file = File(result.files.single.path ?? " ");

    String filename = file.path.split("/").last;

    String filepath = file.path;

    FormData data = FormData.fromMap({
      'key': 'b385d60d49bcf708a6fb7f9837dd12f6',
      'image': await MultipartFile.fromFile(filepath, filename: filename),
      'name': 'house.jpg'
    });

    var response = await dio.post("https://api.imgbb.com/1/upload",
        data: data, onSendProgress: (count, total) => print('$count $total'));
    print(response.data);
  } else {
    print('image is null');
  }
}
