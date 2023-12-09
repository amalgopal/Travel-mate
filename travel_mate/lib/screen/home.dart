import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel_mate/components/app_color.dart';
import 'package:travel_mate/custom_widge/empty_container.dart';
import 'package:travel_mate/custom_widge/home_%20container.dart';

import 'package:travel_mate/custom_widge/ongoing_container.dart';
import 'package:travel_mate/menu%20Screen/side_menu.dart';
import 'package:travel_mate/db/functions/db_function.dart';
import 'package:travel_mate/model/trip_model.dart';
import 'package:travel_mate/model/user_model.dart';

import 'package:travel_mate/sub_screen/ongoing_trip.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_mate/sub_screen/recent_trip.dart';
import 'package:travel_mate/sub_screen/upcoming.dart';

class ScreenHome extends StatefulWidget {
  final UserModel user;
  const ScreenHome({super.key, required this.user});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final PageController _upcomingPageController = PageController();
  final PageController _recentPageController = PageController();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size; 
    //final name =widget.user.userName;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
         elevation: 0,
        backgroundColor: backgroundColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: CircleAvatar(
                      backgroundImage:FileImage(File(widget.user.image!)),
                    ),
        ),
       
        title: Text('I am ${widget.user.username}',
                     style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                    ), 
        actions: [
          IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) =>  SideMenu(user: widget.user,)));
                    },
                    icon: const Icon(Icons.menu_rounded,color: Colors.black,),
                  ),
        ],
       
      ),

      drawer:   SideMenu(user: widget.user,),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              
              children: [
                SizedBox(height: screenSize.height *0.02,),
                Align(
                  alignment: const Alignment(-0.85, -0.75),
                  child: Title(
                    color: Colors.black,
                    child: Text('Ongoing Trip', style: Theme.of(context).textTheme.titleLarge),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.02),
                FutureBuilder(
                  future: getOnGoingTrip(widget.user.id!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final tripData = snapshot.data;
                      return OngoingContainer(
                        coverPic: tripData?.coverPic,
                        destination: tripData?.destination,
                        startingDate: tripData?.startingDate,
                        transportIcon: tripData?.transport,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OngoingTripScreen(
                                user: widget.user,
                                trip: tripData!,
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return EmptyTripContainer(
                        user: widget.user,
                        addIcon: Icons.add_circle_outline,
                        text1: "You don't have ongoing trip",
                        text2: "Add your trip now!",
                      );
                    }
                  },
                ),
                SizedBox(height: screenSize.height * 0.03),
                Align(
                  alignment: const Alignment(-0.85, -0.75),
                  child: Title(
                    color: Colors.black,
                    child: Text('Upcoming Trips', style: Theme.of(context).textTheme.titleLarge),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.02),
                FutureBuilder(
                  future: getUpcomingTrip(widget.user.id!),
                  builder: (context, snapshot) {
                    final List<TripModal>? trips = snapshot.data;
                    if (snapshot.hasData && trips != null && trips.isNotEmpty) {
                      return Column(
                        children: [
                          SizedBox(
                            height: screenSize.height * 0.20,
                            child: PageView.builder(
                              controller: _upcomingPageController,
                              itemCount: trips.length,
                              itemBuilder: (context, index) {
                                final TripModal tripData = trips[index];
                                return UpcomingRecentContainer(
                                  coverPic: tripData.coverPic,
                                  destination: tripData.destination,
                                  startingDate: tripData.startingDate,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UpcomingTripScreen(
                                          user: widget.user,
                                          trip: tripData,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              onPageChanged: (int page) {
                                setState(() {
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: screenSize.height * 0.025,
                            child: SmoothPageIndicator(
                              controller: _upcomingPageController,
                              count: trips.length,
                              effect: WormEffect(
                                spacing: 5,
                                dotWidth: 7,
                                dotHeight: 7,
                                activeDotColor: primaryColor,
                                dotColor: accentColor.withOpacity(0.6),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return EmptyTripContainer(
                        user: widget.user,
                        addIcon: Icons.add_circle_outline,
                        text1: "You don't have any upcoming trips",
                        text2: "Add your trip now!",
                      );
                    }
                  },
                ),
                SizedBox(height: screenSize.height * 0.03),
                Align(
                  alignment: const Alignment(-0.85, -0.75),
                  child: Title(
                    color: Colors.black,
                    child: Text('Recent Trips', style: Theme.of(context).textTheme.titleLarge),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.02),
                FutureBuilder(
                  future: getRecentTrip(widget.user.id!),
                  builder: (context, snapshot) {
                    final List<TripModal>? trips = snapshot.data;
                    if (snapshot.hasData && trips != null && trips.isNotEmpty) {
                      return Column(
                        children: [
                          SizedBox(
                            height: screenSize.height * 0.20,
                            child: PageView.builder(
                              controller: _recentPageController,
                              itemCount: trips.length,
                              itemBuilder: (context, index) {
                                final TripModal tripData = trips[index];
                                return UpcomingRecentContainer(
                                  coverPic: tripData.coverPic,
                                  destination: tripData.destination,
                                  startingDate: tripData.startingDate,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RecentTripScreen(
                                          user: widget.user,
                                          trip: tripData,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              onPageChanged: (int page) {
                                setState(() {
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: screenSize.height * 0.025,
                            child: SmoothPageIndicator(
                              controller: _recentPageController,
                              count: trips.length,
                              effect: WormEffect(
                                spacing: 5,
                                dotWidth: 7,
                                dotHeight: 7,
                                activeDotColor: primaryColor,
                                dotColor: accentColor.withOpacity(0.6),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return EmptyTripContainer(
                        user: widget.user,
                        text1: "You don't have any recent trips :",
                        textStyle: const TextStyle(fontSize: 13),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
