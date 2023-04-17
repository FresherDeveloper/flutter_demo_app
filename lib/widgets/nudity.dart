import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
class CheckNudity extends StatefulWidget {
  const CheckNudity({super.key});

  @override
  State<CheckNudity> createState() => _CheckNudityState();
}

class _CheckNudityState extends State<CheckNudity> {
   File? _imageFile;
  bool _isNudityDetected = false;

  Future<void> _pickImage(ImageSource source) async {
    final imageFile = await ImagePicker().pickImage(source: source);
    if (imageFile != null) {
      setState(() {
        _imageFile = File(imageFile.path);
        _isNudityDetected = false;
      });
      _detectNudity();
    }
  }


Future<void> _detectNudity() async {
  const sightengineApiKey = '1038910598';
  const apiUrl = 'https://api.sightengine.com/1.0/check.json';
  final request = http.MultipartRequest('POST', Uri.parse(apiUrl));
  request.fields['models'] = 'nudity';
  request.fields['api_user'] = sightengineApiKey;
  request.fields['api_secret'] = 'gMfUdBvYx8YzaRR7RJBA';
  request.files.add(http.MultipartFile.fromBytes(
    'media',
    await _imageFile!.readAsBytes(),
    filename: 'image.jpg',
  ));
  final response = await http.Response.fromStream(await request.send());
  final result = jsonDecode(response.body);
  Logger().wtf(result.toString());
  setState(() {
    _isNudityDetected = result['nudity']['raw'] > 0.10;
  });
}

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
          children: <Widget>[
            if (_imageFile != null)
            kIsWeb?Image.network(
                _imageFile!.path,
                height: 200,
              ):  Image.file(
                _imageFile!,
                height: 200,
              )
            else
              const Text('No image selected'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _pickImage(ImageSource.gallery);
              },
              child: const Text('Select an image'),
            ),
            const SizedBox(height: 20),
            if (_isNudityDetected)
              const Text(
                'Nudity content detected!',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      );
    
  }
}