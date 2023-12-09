import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slide_action/slide_action.dart';
import 'package:travel_mate/screen/logORsign.dart';

class ScreenSkip extends StatelessWidget {
  const ScreenSkip({super.key});
  

  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
          //Image.asset('asset/image/cartoon-summer-scene-with-mountain-landscape-forest-meadow-shores-illustration-ai-generated_22200-356.jpg'),
          Expanded(
            child: Container(
             // color: Colors.green.shade900,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('asset/image/cartoon-summer-scene-with-mountain-landscape-forest-meadow-shores-illustration-ai-generated_22200-356.jpg'),fit: BoxFit.cover)
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: screensize.height * 0.03,),
                  const Padding(
                    padding:  EdgeInsets.only(left: 30,),
                    child: Text('''Create Goals
and
Plan Trips''',style:TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 45,),
                    
                    
                    ),
                  ),
                   SizedBox(height: screensize.height * 0.04,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40,),
                    child: SlideAction(trackBuilder: (context, state) {
                              return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child:const Center(
                      child: Text(
                        // Show loading if async operation is being performed
                         "Get Started",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                      ),
                    ),
                              );
                        }, 
                        thumbBuilder:(context, state) {
                              return Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 0, 51, 255),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      // Show loading indicator if async operation is being performed
                      child: state.isPerformingAction
                          ? const CupertinoActivityIndicator(
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                            ),
                    ),
                              );
                        },
                         action: 
                         
                         () async {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(ctx)=>const ScreenLoginOrSignup(),));
                              
                        },
                        ),
                  ),
                  SizedBox(height: screensize.height * 0.1,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}