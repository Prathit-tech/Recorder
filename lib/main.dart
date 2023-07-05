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
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: const Text('Recorder'),
          ),
          body: TabBarView(
            children: [
              MyApp(),
              page2(),
              Center(
                child: Column(
                  children: [
                    Text(
                      'THe same as site 2, uses Listview instead of Listview builder',style: TextStyle(color: Colors.red),
                    ),
                    ListView(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('I am true now'),
                                ]
                              ),

                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}