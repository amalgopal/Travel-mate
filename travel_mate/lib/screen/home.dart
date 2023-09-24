import 'package:flutter/material.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ListTile(
        
        //leading: CircleAvatar(child: Image.asset(''),),
        title: Text('I am Amal'),
        trailing: Icon(Icons.more_vert),
      ), 
    );
  }
}