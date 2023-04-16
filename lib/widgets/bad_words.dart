import 'package:flutter/material.dart';
import 'package:profanity_filter/profanity_filter.dart';

class MyAppTextField extends StatefulWidget {
  const MyAppTextField({super.key});

  @override
  State<MyAppTextField> createState() => _MyAppTextFieldState();
}

class _MyAppTextFieldState extends State<MyAppTextField> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _containsProfanity = false;

  final ProfanityFilter _profanityFilter = ProfanityFilter();

  void _checkForProfanity() {
    setState(() {
      _containsProfanity =
          _profanityFilter.hasProfanity(_textEditingController.text);
    });
    if(_textEditingController.text.isEmpty){
      _containsProfanity=false;
    }
  }
@override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      onChanged: (value) {
        _checkForProfanity();
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'Type something...',
        errorText: _containsProfanity ? 'Text contains bad words.' : null,
      ),
    );
  }
}
