import 'package:flutter/material.dart';
import 'page1.dart';
import 'page2.dart';
import 'ex.dart';
void main() {
  runApp(const mainapp());
}

class mainapp extends StatelessWidget {
  const mainapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.mic)),
                Tab(icon: Icon(Icons.play_arrow)),
                Tab(icon: Icon(Icons.settings)),
              ],
            ),
            title: const Text('Recorder'),
          ),
          body: TabBarView(
            children: [
              MyApp(),
              page2(),
              SimpleRecorder(),
            ],
          ),
        ),
      ),
    );
  }
}