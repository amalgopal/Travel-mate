// import 'package:flutter/material.dart';
// import 'package:travel_mate/db/functions/db_function.dart';
// import 'package:travel_mate/screen/home.dart';

// class ScreenLogin extends StatefulWidget {
//    const ScreenLogin({super.key});

//   @override
//   State<ScreenLogin> createState() => _ScreenLoginState();
// }

// class _ScreenLoginState extends State<ScreenLogin> {
// final _usernameController= TextEditingController();

// final _passwordController= TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        resizeToAvoidBottomInset : false,
//       body: Column(
//         children: [
//          const SizedBox(height: 100,),
//           SizedBox(
//             height: 300,
//            // width: 200,
//            child: Center(child: Image.asset('asset/image/Screenshot 2023-09-03 190112.jpg'))
//           ),
//            const Padding(
//              padding:  EdgeInsets.symmetric(vertical: 40,),
//              child:  Text('Log in to your account',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20, ),),
//            ),
          
//           const SizedBox(height: 60,),
          
//          SizedBox(
//          // height: 50,
//           width: 350,
//           child:  TextFormField(
            
//          controller: _usernameController,
//             decoration:const InputDecoration(
//               filled: true,
//               fillColor: Colors.grey,
//               border: OutlineInputBorder(),
//               hintText: 'Enter your username'
//             ),
//             validator: (value) {
//               if(value==null ||value.isEmpty){
//                 return 'value is Empty';
//               }else{
//                 return null;
//               }

//             },
//           ),
//          ),
//         const SizedBox(height: 30),
//           SizedBox(
//             width: 350,
//             child: TextFormField(
//               controller: _passwordController,
//               obscureText: true,
//               decoration: const InputDecoration(
//                 filled: true,
//                 fillColor: Colors.grey,
//                 border: OutlineInputBorder(),
//                 hintText: 'Enter your password'
                
//               ),
//               validator: (value){
//                 if(value==null||value.isEmpty){
//                   return 'value is Empty';
//                 }else{
//                 return null;
//                 }
//               },
//             ),
//           ),
//           const SizedBox(height: 50,),
//           SizedBox(
//             height: 60,
//             width: 280,
//             child: ElevatedButton(onPressed:(){
//                login();
//             }, child: const Text('Log In',/*style: TextStyle(color: ),*/)),
//           )
         
//         ],
//       ),
//     );
//   }

//   Future<void>login()async{
//     final username =_usernameController;
//     final password =_passwordController;
    
//     final user = await validateUser(usernameas String , password as String );
//     if(user!=null){
//       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: ((context) =>const ScreenHome())), (route) => false);
      
//     }else{
//       // ignore: use_build_context_synchronously
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid Login. please check your username and password'),
//       behavior: SnackBarBehavior.floating,));
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:travel_mate/db/functions/db_function.dart';
import 'package:travel_mate/screen/home.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  _ScreenLoginState createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const SizedBox(height: 100,),
          SizedBox(
            height: 300,
            child: Center(
              child: Image.asset('asset/image/Screenshot 2023-09-03 190112.jpg'),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 40,),
            child: Text(
              'Log in to your account',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
            ),
          ),
          const SizedBox(height: 60,),
          SizedBox(
            width: 350,
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
          const SizedBox(height: 30),
          SizedBox(
            width: 350,
            child: TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(),
                hintText: 'Enter your password',
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
          const SizedBox(height: 50,),
          SizedBox(
            height: 60,
            width: 280,
            child: ElevatedButton(
              onPressed: () {
                login();
              },
              child: const Text('Log In'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final user = await validateUser(username, password);
    if (user != null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const ScreenHome()),
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

