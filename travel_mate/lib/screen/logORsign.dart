// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:travel_mate/screen/login.dart';
import 'package:travel_mate/screen/signup.dart';

class ScreenLoginOrSignup extends StatelessWidget {
  const ScreenLoginOrSignup({super.key});

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screensize.height * 0.10,),
            Image.asset('asset/image/vector-tourist-couples-with-travel-bags-illustration_575980-4163.jpg'),
             SizedBox(height: screensize.height * 0.11,),
            SizedBox(
              height: screensize.height * 0.07,
              width: screensize.width * 0.70,
              child: ElevatedButton(
                style:ElevatedButton.styleFrom(backgroundColor: Colors.grey) ,
                onPressed: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>ScreenLogin()));
                   },
                    child: const Text('Log In',style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold ),)),
            ),
             SizedBox(height: screensize.height * 0.06,),
            SizedBox(
             height: screensize.height * 0.07,
             width: screensize.width * 0.70,
             
             child:  ElevatedButton(
               style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
               
               onPressed: (){
                 Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> ScreenSigup()),);}, child: const Text('Sign Up',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
               ),
            ),
            SizedBox(height:screensize.height * 0.25),
           
            const Center(
              child: Text('version 1.0.2',style: TextStyle(color: Colors.grey),),
            )
          ],
        ),
      )
      
    );
  }
}