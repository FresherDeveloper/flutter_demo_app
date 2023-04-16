import 'package:demo_fluttter_app/widgets/bad_words.dart';
import 'package:demo_fluttter_app/widgets/pick_image.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [
            MyAppTextField(),
            SizedBox(height: 20,),
            PickImage()
          ],
        ),
      ),
    );
  }
}
