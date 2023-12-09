import 'package:flutter/material.dart';
import 'package:travel_mate/components/app_color.dart';
import 'package:travel_mate/db/functions/db_function.dart';
import 'package:travel_mate/menu%20Screen/profile%20.dart';

import 'package:travel_mate/model/user_model.dart';

class EditPassword extends StatelessWidget {
  final UserModel user;
    EditPassword({super.key, required this.user});
    
final _changepasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size; 
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.arrow_back,color: Colors.black,)),
        title: const Text('Change Password',style: TextStyle(color: Colors.black),),

      ),
      body: Column(
        children: [
          SizedBox(height: screenSize.height * 0.03,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              controller: _changepasswordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder()
              ),
              
            ),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 155),
        child: ElevatedButton(onPressed: (){
          updatePassword(context);
        }, child: const Text('UPDATE')),
      ),
    );
  }
  updatePassword(context){
    
    String passwordupdate =_changepasswordController.text.toString();
  
    updateUserinfo('password', passwordupdate, user.id!);
    passwoerd = passwordupdate;
    Navigator.of(context).pop();
  }
}