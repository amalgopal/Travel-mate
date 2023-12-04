import 'package:flutter/material.dart';

class SideManuTile extends StatelessWidget {
  const SideManuTile({
    super.key, required this.icon1, required this.name, required this.icon2, required this.navigator, 
  });
  final IconData icon1;
  final String name;
  final IconData icon2;
  final Function()? navigator;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      const  Padding(
          padding:  EdgeInsets.only(bottom:1,top: 1),
          child:  Divider(
            color: Colors.grey,
            height: 1,
          ),
        ),
        ListTile(
          onTap: navigator,
          leading: Icon(icon1),
          title: Text(name),
          trailing: Icon(icon2 ),
          
        ),
      ],
    );
  }
}
