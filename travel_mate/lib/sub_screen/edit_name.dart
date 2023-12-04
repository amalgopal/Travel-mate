import 'package:flutter/material.dart';
import 'package:travel_mate/components/app_color.dart';
import 'package:travel_mate/db/functions/db_function.dart';
import 'package:travel_mate/model/user_model.dart';

class EditName extends StatelessWidget {
  final UserModel user;
   EditName({super.key, required this.user});


  final _changenameController = TextEditingController();
  
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size; 
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.arrow_back,color: Colors.black,)),
        title: const Text('Change Name',style: TextStyle(color: Colors.black),),
      ),
      body: Column(
        children: [
          SizedBox(height: screenSize.height * 0.03,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              controller: _changenameController,
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
        updatename(context);
        }, child: const Text('UPDATE')),
      ),
    );
  }
  updatename(context){
    String name = _changenameController.toString();
      updateUserinfo('username', name  ,user.id! );
          Navigator.of(context).pop();
  }
}