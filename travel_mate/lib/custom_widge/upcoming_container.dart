import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UpcomnigContainer extends StatelessWidget {
  //final Image image;
  double redius;
  double width;
  double height;
   UpcomnigContainer({super.key, required this.height,required this.width,required this.redius});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(redius)
      ),
      
    );
  }
}