import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_mate/db/functions/db_function.dart';
import 'package:travel_mate/menu%20Screen/profile%20.dart';


import 'package:travel_mate/menu%20Screen/app_info.dart';
import 'package:travel_mate/model/user_model.dart';


import 'package:travel_mate/menu%20Screen/privacy_policy.dart';
import 'package:travel_mate/screen/logORsign.dart';
String name ='';
String mail='';


class SideMenu extends StatefulWidget {
  final UserModel user;
  // Corrected class name
  const SideMenu({Key? key, required this.user}) : super(key: key); 
  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
 // Corrected constructor
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('asset/image/cartoon-summer-scene-with-mountain-landscape-forest-meadow-shores-illustration-ai-generated_22200-356.jpg',),fit: BoxFit.cover)
              ),
              accountName: Text(name!=''?name:widget.user.username),
              accountEmail: Text(mail !=''?mail : widget.user.mail),
              currentAccountPicture: CircleAvatar(
                backgroundImage: FileImage(File(widget.user.image!)),
                
              ),
            ),
             ListTile(
        leading: const Icon(Icons.account_box),
        title: const Text('Profile'),
        trailing: const Icon(Icons.arrow_right, ),
         onTap: ()async{
         final data= await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>  ScreenProfile(user: widget.user,),
                  ),
                );
                if(data ==true){
                  setState(() {
                    
                  });((){});
                }
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
        //     ListTile(
        // leading: const Icon(Icons.delete_outline_outlined),
        // title: const Text('Clear App Data'),
        // trailing: const Icon(Icons.arrow_right, ),
        //  onTap: (){
        //  },
        // ),
         ListTile(
        leading: const Icon(Icons.logout_outlined),
        title: const Text('Sign Out'),
        trailing: const Icon(Icons.arrow_right, ),
         onTap: ()async{
          await signoutDialog(context);
         },
        ),
           
           
          ],
        ),
      
    );
  }

Future<void> signoutDialog(context)async{
  showDialog(context: (context),
   builder: (ctx)=>CupertinoAlertDialog(
    title: const Text('Signout'),
    content: const Text('Are you sure, do you want to signout'),
    actions: [
      CupertinoDialogAction(child: const Text('No'),
      onPressed: (){
        Navigator.of(context).pop();
      },),
      CupertinoDialogAction(child: const Text('Yes',style: TextStyle(color: Colors.red),),
      onPressed: ()async{
       await signoutUser();
       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>const ScreenLoginOrSignup()), (route) => false);
      },)
    ],
  ));
}
}
