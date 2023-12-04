import 'package:flutter/material.dart';
import 'package:travel_mate/components/app_color.dart';

class ScreenPrivecy extends StatelessWidget {
  const ScreenPrivecy({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.arrow_back,color: Colors.black,) ),
        title: const Text('Privacy & Policy',style: TextStyle(color: Colors.black),),
         
        
      ),
      body:Padding(
        padding: const EdgeInsets.only(top: 10,left: 30,right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lorem Ipsum',style: TextStyle(fontWeight: FontWeight.bold),),
          
            SizedBox(height:screenSize.height * 0.01),
            Text('''Lorem Ipsum is simply dummy text of the printing and 
typesetting industry. Lorem Ipsum has been the 
industry's standard dummy text ever since the 1500s,
when an unknown printer took a galley of type and
scrambled it to make a type specimen book.''',style: TextStyle(color: Colors.grey.shade600),)
          ],
        ),
      ),
      
    );
  }
}