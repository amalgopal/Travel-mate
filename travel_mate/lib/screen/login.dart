import 'package:flutter/material.dart';
import 'package:travel_mate/custom_widge/bottom_navigation.dart';
import 'package:travel_mate/db/functions/db_function.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  _ScreenLoginState createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordObscure =true;

void _togglePasswordVisibility() {
  setState(() {
    _isPasswordObscure = !_isPasswordObscure;
  });
}
  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return Scaffold(
      
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Column(
            children: [
             SizedBox(height:screensize.height * 0.11,),
              SizedBox(
                height: screensize.height * 0.35,
                child: Center(
                  child: Image.asset('asset/image/Screenshot 2023-09-03 190112.jpg'),
                ),
              ),
              SizedBox(height: screensize.height * 0.05,),
             const Text(
                'Log in to your account',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
              ),
               SizedBox(height: screensize.height * 0.05,),
              SizedBox(
                width: screensize.width * 0.85,
                child: TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(),
                    hintText: 'Enter your username',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is empty';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
               SizedBox(height: screensize.height * 0.04),
              SizedBox(
                width: screensize.width * 0.85,
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: _isPasswordObscure,
                  decoration:  InputDecoration(
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
                      return 'Password is empty';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
               SizedBox(height: screensize.height * 0.05,),
              SizedBox(
                height: screensize.height * 0.06,
                width: screensize.width * 0.6,
                child: ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  child: const Text('Log In'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    if(formKey.currentState!.validate()){
    final username = _usernameController.text;
    final password = _passwordController.text;

    final user = await validateUser(username, password);
    if (user != null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) =>  BotteomBar(userdata:user)),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Login. Please check your username and password'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
  }
}

