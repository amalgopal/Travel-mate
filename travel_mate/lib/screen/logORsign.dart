// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:travel_mate/screen/login.dart';
import 'package:travel_mate/screen/signup.dart';

class ScreenLoginOrSignup extends StatelessWidget {
  const ScreenLoginOrSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      body: Column(
        children: [
          const SizedBox(height: 100,),
          Image.asset('asset/image/vector-tourist-couples-with-travel-bags-illustration_575980-4163.jpg'),
          const SizedBox(height: 100,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
                width: 280,
                child: ElevatedButton(
                  style:
                 
                  ElevatedButton.styleFrom(backgroundColor: Colors.grey) ,
                  onPressed: (){ Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>ScreenLogin()));}, child: const Text('Log In',style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold ),)),
              )
             
            ],
          ),
          const SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             SizedBox(
              height: 60,
              width: 280,
              
              child:  ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                
                onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> ScreenSigup()),);}, child: const Text('Sign In',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                ),
             ),
             
          ],
          ),
          const SizedBox(height:280),
         
          const Center(
            child: Text('version 1.0.2',style: TextStyle(color: Colors.grey),),
          )
        ],
      )
      
    );
  }
}