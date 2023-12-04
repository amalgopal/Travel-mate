import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel_mate/db/functions/db_function.dart';
import 'package:travel_mate/menu%20Screen/profile%20.dart';


import 'package:travel_mate/menu%20Screen/app_info.dart';
import 'package:travel_mate/model/user_model.dart';
import 'package:travel_mate/screen/logORsign.dart';

import 'package:travel_mate/menu%20Screen/privacy_policy.dart';

class SideMenu extends StatelessWidget {
  final UserModel user;
  // Corrected class name
  const SideMenu({Key? key, required this.user}) : super(key: key); // Corrected constructor

  // Corrected class name
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('asset/image/cartoon-summer-scene-with-mountain-landscape-forest-meadow-shores-illustration-ai-generated_22200-356.jpg',),fit: BoxFit.cover)
              ),
              accountName: Text(user.username),
              accountEmail: Text(user.mail),
              currentAccountPicture: CircleAvatar(
                backgroundImage: FileImage(File(user.image!)),
                
              ),
            ),
             ListTile(
        leading: const Icon(Icons.account_box),
        title: const Text('Profile'),
        trailing: const Icon(Icons.arrow_right, ),
         onTap: (){
           Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>  ScreenProfile(user: user,),
                  ),
                );
         },
        ),
             ListTile(
        leading: const Icon(Icons.lock_outlined),
        title: const Text('Privacy & policy'),
        trailing: const Icon(Icons.arrow_right, ),
         onTap: (){
           Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ScreenPrivecy(),
                  ),
                );
         },
        ),
        
           ListTile(
        leading: const Icon(Icons.info_outline),
        title: const Text('App Info'),
        trailing: const Icon(Icons.arrow_right, ),
         onTap: (){
           Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const  ScreenAppInfo(),
                  ),
                );
         },
        ),
            ListTile(
        leading: const Icon(Icons.delete_outline_outlined),
        title: const Text('Clear App Data'),
        trailing: const Icon(Icons.arrow_right, ),
         onTap: (){
         },
        ),
         ListTile(
        leading: const Icon(Icons.logout_outlined),
        title: const Text('Sign Out'),
        trailing: const Icon(Icons.arrow_right, ),
         onTap: (){
          signoutUser();
           Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const  ScreenLoginOrSignup(),
                  ),
                );
         },
        ),
           
           
          ],
        ),
      
    );
  }


 // Corrected class name
}
