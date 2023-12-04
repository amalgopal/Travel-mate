

import 'package:flutter/material.dart';
import 'package:travel_mate/components/image_picker.dart';
import 'package:travel_mate/custom_widge/bottom_navigation.dart';
import 'package:travel_mate/db/functions/db_function.dart';
import 'package:travel_mate/model/user_model.dart';


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
   bool _isPasswordObscure = true;
   bool _isCPasswordObscure = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordObscure = !_isPasswordObscure;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isCPasswordObscure = !_isCPasswordObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return Scaffold(
      
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                children: [
                   SizedBox(height: screensize.height * 0.06, ),
                  
                  
                  Text('Create a new account',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  SizedBox(height: screensize.height * 0.06,),
                  ProfileImagePicker(),
                   SizedBox(height: screensize.height * 0.06,),
                  SizedBox(
                    width: screensize.width * 0.85,
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
                   SizedBox(height: screensize.height * 0.02,),
                  SizedBox(
                    width: screensize.width * 0.85,
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
                            return 'Emai is required';
                          } else {
                            return null;
                          }
                      }
                    ),
                  ),
                   SizedBox(height: screensize.height * 0.02),
                  SizedBox(
                    width: screensize.width * 0.85,
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: _isPasswordObscure,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(),
                        hintText: 'Enter your password',
                        suffixIcon: IconButton(
                icon: _isPasswordObscure
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
                onPressed: _togglePasswordVisibility,
              ) ,
                      ),
                      validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          } else {
                            return null;
                          }
                      }
                    ),
                  ),
                   SizedBox(height: screensize.height * 0.02),
                  SizedBox(
                    width: screensize.width * 0.85,
                    child: TextFormField(
                      obscureText: _isCPasswordObscure,
                      decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey,
                      border: OutlineInputBorder(),
                      hintText: 'Confirm password',
                      suffixIcon: IconButton(
                icon: _isCPasswordObscure
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
                onPressed: _toggleConfirmPasswordVisibility,
              ) ,
                    ),
                    validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'confirm is required';
                          } else {
                            return null;
                          }
                    }
                    ),
                  ),
                  SizedBox(height: screensize.height * 0.06,),
                  SizedBox(
                    height: screensize.height * 0.06,
                    width: screensize.width * 0.6,
                    child:ElevatedButton(onPressed: (){
                      onSignupButtonClicked();
                    }, child: const Text('Sign Up',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),)) ,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
onSignupButtonClicked() async {
  if (formKey.currentState!.validate()) {
    if (image == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please add an image before submitting the form.'),
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }

    final username = _usernameController.text.trim();
    final mail = _mailcontroller.text.trim();
    final password = _passwordController.text.trim();

    // Email validation using a regular expression
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(mail)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter a valid email address.'),
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }

    final nameExists = await checkIfNameExists(username);

    if (nameExists) {
      // Show an error message if the username already exists in the database.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('This username is already registered. Please use a different username.'),
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }

    final user = UserModel(
      username: username,
      mail: mail,
      password: password,
      image: image?.path,
    );

    int userId = await addUser(user);
    user.id = userId;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx) => BotteomBar(userdata: user)),
      (route) => false,
    );
  }
}
 
  //Email validation
  bool isEmailValid(String email) {
    // Regular expression pattern for email validation
    String pattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

}