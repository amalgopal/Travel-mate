import 'package:flutter/material.dart';
import 'package:travel_mate/db/functions/db_function.dart';
import 'package:travel_mate/screen/splash.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
   initializeDataBase();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      
      debugShowCheckedModeBanner: false,
      
      home: ScreenSplash(),
    );
  }
}