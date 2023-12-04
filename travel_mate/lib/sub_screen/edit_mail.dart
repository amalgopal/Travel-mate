import 'package:flutter/material.dart';
import 'package:travel_mate/components/app_color.dart';
import 'package:travel_mate/db/functions/db_function.dart';
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
        }, icon: Icon(Icons.arrow_back,color: Colors.black,)),
        title: Text('Change Mail',style: TextStyle(color: Colors.black),),

      ),
      body: Column(
        children: [
          SizedBox(height: screenSize.height * 0.03,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              controller: _changemailController,
              decoration: InputDecoration(
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
        }, child: Text('UPDATE')),
      ),
    );
  }
  updateMail(context){
    String mail = _changemailController.toString();
    updateUserinfo('mail', mail,user.id! );
    Navigator.of(context).pop();
  }
}