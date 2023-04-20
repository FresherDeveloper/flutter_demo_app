import 'package:demo_fluttter_app/widgets/nudity.dart';
import 'package:demo_fluttter_app/widgets/bad_words.dart';
import 'package:demo_fluttter_app/widgets/pick_image.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle customStyle = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Demo"),
        actions: [
          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PickImage(),));
          }, child: Text("click"))
        ],
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "check bad words",
                style: customStyle,
              ),
              SizedBox(
                height: 10,
              ),
              MyAppTextField(),
              SizedBox(
                height: 30,
              ),
              Text("check nudity content of image", style: customStyle),
              SizedBox(
                height: 10,
              ),
              CheckNudity()
            ],
          ),
        ),
      ),
    );
  }
}
