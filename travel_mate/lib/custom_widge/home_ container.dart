// ignore_for_file: must_be_immutable
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel_mate/components/app_color.dart';


class UpcomingRecentContainer extends StatelessWidget {
  Function()? onTap;
  final coverPic;
  final destination;
  final startingDate;
  final transportIcon;
  UpcomingRecentContainer({
    super.key,
    this.onTap,
    this.coverPic,
    this.destination,
    this.startingDate,
    this.transportIcon,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 1, right: 1),
        child: Container(
          
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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 13, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        child: Icon(
                          Icons.flight,
                          size: 15,
                          color: primaryColor,
                        ),
                        maxRadius: 11,
                        backgroundColor: backgroundColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.108,
                  ),
                Container(
                  color: Colors.black,
                  child: Column(
                    
                    children: [
                        Text(
                      destination != null ? destination : 'no data',
                      style: const TextStyle(
                          color: backgroundColor, fontWeight: FontWeight.w600),
                    ),
                    Text(startingDate != null ? startingDate : 'data',
                        style: const TextStyle(color: backgroundColor, fontSize: 11))
                    ],
                  ),
                )
                ],
              ),
            )),
      ),
    );
  }
}
