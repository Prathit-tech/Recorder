import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'checkbox_component.dart';
import 'progressbar.dart';
class page2 extends StatefulWidget {
  const page2({Key? key}) : super(key: key);

  @override
  _page2State createState() => _page2State();
}

class _page2State extends State<page2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          width: 500,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30))
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,8,0,4),
                    child: Row(
                      children: [
                        Icon(Icons.fast_forward),
                        Icon(Icons.fast_forward),
                        Icon(Icons.fast_forward),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.fast_rewind),
                      SizedBox( width: 50,height: 6,
                      child: Container(
                        color: Colors.white,
                      ),
                      ),
                      Icon(Icons.fast_rewind)
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.fast_rewind),
                  SizedBox( width: 50,height: 6,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  Icon(Icons.fast_rewind)
                ],
              )
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height - 300,
          width: 500,
          child: ListView.builder(itemCount: 5, itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: CheckboxExample(),
                trailing: Column(
                  children: [
                    const Text(
                    "...",
                    style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                  ],
                ),
                title: Column(
                  children: [
                    Text("List item $index"),
                    Text('data data',style: TextStyle(fontSize: 12),),
                  ],
                ));
                }),
        ),
          ],
    );
  }
}
