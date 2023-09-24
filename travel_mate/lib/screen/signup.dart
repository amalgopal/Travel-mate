import 'package:flutter/material.dart';
import 'package:travel_mate/db/functions/db_function.dart';
import 'package:travel_mate/model/user_model.dart';
import 'package:travel_mate/screen/home.dart';

class ScreenSigup extends StatefulWidget {
   const ScreenSigup({super.key});

  @override
  State<ScreenSigup> createState() => _ScreenSigupState();
}

class _ScreenSigupState extends State<ScreenSigup> {
  final formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  final _mailcontroller =TextEditingController();

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       resizeToAvoidBottomInset : false,
      body: Column(
        children: [
          const SizedBox(height: 15, ),
          Image.asset('asset/image/18378.jpg'),
          const Padding(
            padding:  EdgeInsets.symmetric(horizontal: 40),
            child: Text('Create a new account',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          ),
          const SizedBox(height: 25,),
          SizedBox(
            width: 350,
            child: Form(
              key: formKey,
              child: TextFormField(
              controller:_usernameController ,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(),
                  hintText: 'Enter your username'
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username is required';
                  } else {
                    return null;
                  }
                }
              ),
            ),
          ),
          const SizedBox(height: 20,),
          SizedBox(
            width: 350,
            child: TextFormField(
              controller: _mailcontroller,
              decoration : const InputDecoration(
                filled : true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(),
                hintText: 'Enter your email'
              ),
              validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username is required';
                  } else {
                    return null;
                  }
              }
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 350,
            child: TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration:const InputDecoration(
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(),
                hintText: 'Enter your password'
              ),
              validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username is required';
                  } else {
                    return null;
                  }
              }
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 350,
            child: TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.grey,
              border: OutlineInputBorder(),
              hintText: 'confirm password'
            ),
            validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username is required';
                  } else {
                    return null;
                  }
            }
            ),
          ),
          const SizedBox(height: 25,),
          SizedBox(
            height: 60,
            width: 280,
            child:ElevatedButton(onPressed: (){
              onSignupButtonClicked();
            }, child: const Text('Sign Up',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),)) ,)
        ],
      ),
    );
  }
  onSignupButtonClicked()async{
    if(formKey.currentState!.validate()) {
      final username=_usernameController.text.trim();
      final mail =_mailcontroller.text.trim();
      final password =_passwordController.text.trim();
      
      final user = UserModel(
        userName: username, mail: mail,password: password );
        addUser(user);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (ctx)=>ScreenHome()), (route) => false);
    }
  }
}