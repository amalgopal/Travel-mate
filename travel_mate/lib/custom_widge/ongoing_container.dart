// ignore_for_file: must_be_immutable
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:travel_mate/components/app_color.dart';


class OngoingContainer extends StatelessWidget {
  Function()? onTap;
  final coverPic;
  final destination;
  final startingDate;
  final transportIcon;
  OngoingContainer(
      {Key? key,
      this.onTap,
      this.coverPic,
      this.destination,
      this.startingDate,
      this.transportIcon});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: screenSize.height * 0.23,
            width: screenSize.width * 0.99,
            decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: coverPic != null
                        ? FileImage(
                            File(coverPic),
                          )
                        : AssetImage('assets/app_logo.png') as ImageProvider)),
          ),
        ),
        SizedBox(
          height: screenSize.height * 0.015,
        ),

        //ongoing transport icon,place,starting date
        Row(
          children: [
            CircleAvatar(
              backgroundColor: accentColor2,
              maxRadius: 13,
              child: Icon(
                Icons.train,
                size: 17,
                color: primaryColor,
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: screenSize.width * 0.02,
                ),
                Text(destination != null ? destination : 'no data'),
                SizedBox(
                  width: screenSize.width * 0.04,
                ),
                Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: accentColor2,
                        maxRadius: 13,
                        child: Icon(
                          Icons.calendar_month,
                          size: 15,
                          color: primaryColor,
                        )),
                    SizedBox(
                      width: screenSize.width * 0.02,
                    ),
                    Text(startingDate != null ? startingDate : 'data')
                  ],
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
