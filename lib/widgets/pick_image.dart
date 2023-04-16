import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  const PickImage({super.key});

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File? pickedImage;
  bool isPicked = false;

  final ImagePicker _picker = ImagePicker();
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    pickedImage = File(pickedFile!.path);

    setState(() {
      isPicked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: isPicked
                  ? kIsWeb
                      ? Image.network(pickedImage!.path)
                      : Image.file(
                          pickedImage!,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width * (4 / 3),
                        )
                  : Container(
                      color: Colors.blueGrey[100],
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width * (4 / 3),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(48.0),
            child: ElevatedButton(
              onPressed: () async {
                await _pickImage(ImageSource.gallery);
              },
              child: const Text("Pick Image from Gallery"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 48),
            child: ElevatedButton(
              onPressed: () async {
                await _pickImage(ImageSource.camera);
              },
              child: const Text("Capture a photo"),
            ),
          ),
        ],
      ),
    );
  }
}
