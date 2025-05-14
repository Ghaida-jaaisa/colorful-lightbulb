import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

 Color _color = Colors.black;

final List<Color> _colors = [Colors.red , Colors.blue , Colors.yellow , Colors.green , Colors.orange , Colors.purple , Colors.pink];

  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Gesture Detector") , centerTitle: true,),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.lightbulb,
                size: 60.0,
                color: _color,
              ),

              ..._colors.map((color) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _color = color;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.circle,
                          color: color,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              OutlinedButton(onPressed: () {
                setState(() {
                  _color = Colors.black;
                });
              },
                  child: Text("Reset to Default -- Black"))
            ],
          ),
        ),
      ),
    );
  }

}
