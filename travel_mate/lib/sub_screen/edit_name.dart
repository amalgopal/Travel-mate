import 'package:flutter/material.dart';
import 'package:travel_mate/components/app_color.dart';
import 'package:travel_mate/db/functions/db_function.dart';
import 'package:travel_mate/model/user_model.dart';
import '../menu Screen/side_menu.dart';

class EditName extends StatelessWidget {
  final UserModel user;
   EditName({super.key, required this.user});


  final _changenameController = TextEditingController();
  
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
    String nameupdate = _changenameController.text.toString();
      updateUserinfo('username', nameupdate  ,user.id! );
      name=nameupdate;
          Navigator.of(context).pop();
  }
}