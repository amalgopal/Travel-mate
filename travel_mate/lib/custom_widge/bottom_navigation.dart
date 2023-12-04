


import 'package:flutter/material.dart';
import 'package:travel_mate/model/user_model.dart';

import 'package:travel_mate/screen/add_trip.dart';
import 'package:travel_mate/screen/home.dart';
import 'package:travel_mate/screen/search.dart';

class BotteomBar extends StatefulWidget {
  final UserModel userdata;
  
  const BotteomBar({Key? key, required this.userdata}) : super(key: key);

  @override
  _BotteomBarState createState() => _BotteomBarState();
}

class _BotteomBarState extends State<BotteomBar> {
  int myIndex = 0;
  List<Widget> bottomList=[];
  
// BotteomBar get widget;
  @override
  void initState() {
    super.initState();
     bottomList = [
    ScreenHome(user: widget.userdata),
    ScreenSearch(user: widget.userdata,),
  ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomList[myIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ScreenAddTrip(user: widget.userdata)));
        },
        child: Icon(Icons.add, color: Colors.black),
        backgroundColor: Colors.yellow,
      ),
      bottomNavigationBar: BottomNavigationBar(
          
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        items: const [
          
          BottomNavigationBarItem(
            
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
            backgroundColor: Colors.white,
            tooltip: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.white),
            label: 'Search',
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

