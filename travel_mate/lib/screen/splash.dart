import 'package:flutter/material.dart';
import 'package:travel_mate/screen/skip.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});
  

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
   gotoLogin();
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('asset/image/Screenshot 2023-09-03 172946.jpg',height: double.infinity,)),
    );
  }
 
 Future<void> gotoLogin() async {
  await Future.delayed(const Duration(seconds: 3));
  
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => const ScreenSkip()));
}

}