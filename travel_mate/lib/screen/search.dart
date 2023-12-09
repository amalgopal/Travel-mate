import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel_mate/db/functions/db_function.dart';
import 'package:travel_mate/model/trip_model.dart';
import 'package:travel_mate/model/user_model.dart';
import 'package:travel_mate/sub_screen/ongoing_trip.dart';

class ScreenSearch extends StatefulWidget {
  final UserModel user;

  const ScreenSearch({
    Key? key, // Fix the key parameter
    required this.user,
  }) : super(key: key);

  @override
  _ScreenSearchState createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  final searchResult = ValueNotifier<List<TripModal>>([]);
  List<TripModal> allTrips = [];

  @override
  void initState() {
    super.initState();
    getTrips();
  }

  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: screensize.height * 0.02,
              ),
              TextFormField(
                onChanged: (value) {
                  searchResult.value = allTrips
                      .where((trip) =>
                          trip.tripName.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(172, 158, 158, 158),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: 'Searching...',
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
              SizedBox(
                height: screensize.height * 0.02,
              ),
              Expanded(
                child: ValueListenableBuilder<List<TripModal>>(
                  valueListenable: searchResult,
                  builder: (context, value, _) {
                    return value.isEmpty ? const Center(child: Text('Now result found',style: TextStyle(fontWeight: FontWeight.bold),),)
                    : ListView.builder(
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: value.length,
                      itemBuilder: (context, index) => Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => OngoingTripScreen(
                                user: widget.user,
                                trip: value[index],
                              ),
                            ));
                          },
                          leading: CircleAvatar(
                            backgroundImage: FileImage(File(value[index].coverPic!)),
                          ),
                          title: Text(value[index].tripName),
                          subtitle: Text(value[index].destination),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getTrips() async {
    allTrips = await alltripDetails(widget.user.id!);
    searchResult.value = List<TripModal>.from(allTrips);
  }
}
