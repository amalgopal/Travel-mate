


import 'package:flutter/material.dart';

import 'package:travel_mate/components/app_color.dart';
import 'package:travel_mate/components/edite_image.dart';
import 'package:travel_mate/model/user_model.dart';
import 'package:travel_mate/sub_screen/edit_mail.dart';
import 'package:travel_mate/sub_screen/edit_name.dart';
import 'package:travel_mate/sub_screen/edit_password.dart';

class ScreenProfile extends StatelessWidget {
  final UserModel user;

  const ScreenProfile({super.key, required this.user});

  String formatPassword(String password) {
    if (password.length <= 3) {
      return password; 
    } else {
      String obscuredPart = '*' * (password.length - 3); // Obscure all characters except the last 3
      String lastThreeDigits = password.substring(password.length - 3);
      return '$obscuredPart$lastThreeDigits';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenSize.height * 0.04,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EditeImagePicker(user: user),
            ],
          ),
          SizedBox(height: screenSize.height * 0.04,),
          ListTile(
            leading: const Icon(Icons.account_box_outlined),
            title: const Text('Name'),
            subtitle: Text(user.username, ),
            trailing: TextButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> EditName(user: user,)));
            }, child: const Text('Edit')),
          ),
          SizedBox(height: screenSize.height * 0.03),
          ListTile(
            leading: const Icon(Icons.mail_outline),
            title: const Text('Mail'),
            subtitle: Text(user.mail),
            trailing: TextButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> EditMail(user: user,)));
            }, child: const Text('Edit')),
          ),
          SizedBox(height: screenSize.height * 0.03),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Password'),
            subtitle: Text(formatPassword(user.password)),
            trailing: TextButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>EditPassword(user: user,)));
            }, child: const Text('Change')),
          )
        ],
      ),
    );
  }
}
