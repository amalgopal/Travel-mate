import 'package:flutter/material.dart';
import 'package:travel_mate/components/app_color.dart';
import 'package:travel_mate/db/functions/db_function.dart';
import 'package:travel_mate/menu%20Screen/side_menu.dart';
import 'package:travel_mate/model/user_model.dart';

class EditMail extends StatelessWidget {
  final UserModel user;
    EditMail({super.key, required this.user});
final _changemailController = TextEditingController();
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
        }, icon:const Icon(Icons.arrow_back,color: Colors.black,)),
        title:const Text('Change Mail',style: TextStyle(color: Colors.black),),

      ),
      body: Column(
        children: [
          SizedBox(height: screenSize.height * 0.03,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _changemailController,
              decoration:const InputDecoration(
                border: OutlineInputBorder()
              ),
              
            ),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 155),
        child: ElevatedButton(onPressed: (){
          updateMail(context);
        }, child:const Text('UPDATE')),
      ),
    );
  }
  updateMail(context){
    String mailupodate = _changemailController.text.toString();
    updateUserinfo('mail', mailupodate,user.id! );
    mail=mailupodate;
    Navigator.of(context).pop();
  }
}