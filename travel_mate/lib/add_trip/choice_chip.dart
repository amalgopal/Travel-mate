import 'package:flutter/material.dart';

import 'package:travel_mate/components/app_color.dart';
import 'package:travel_mate/screen/add_trip.dart';


class MyChoiceChip extends StatefulWidget {
  final List<String> choices = [
    'Flight',
    'Car ',
    'Train',
    'Bike  ',
    'Ship',
    'Other'
  ];
  final List<Icon> icons = [
    Icon(Icons.flight_takeoff_rounded),
    Icon(Icons.directions_car_rounded),
    Icon(Icons.train_rounded),
    Icon(Icons.directions_bike_rounded),
    Icon(Icons.directions_boat),
    Icon(Icons.commute),
  ];

  MyChoiceChip({Key? key}) : super(key: key);

  @override
  State<MyChoiceChip> createState() => _MyChoiceChipState();
}

class _MyChoiceChipState extends State<MyChoiceChip> {
  int? _value;

  @override
  Widget build(BuildContext context) {
    // final TextTheme textTheme = Theme.of(context).textTheme;

    return Wrap(
      spacing: 8,
      children: List.generate(
        widget.choices.length,
        (int index) {
          return Container(
            height: 50,
            width: 112,
            child: ChoiceChip(
              padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
              avatar: widget.icons[index],
              selectedColor: primaryColor,
              backgroundColor: backgroundColor,
              iconTheme: IconThemeData(
                color: accentColor,
                size: 17,
              ),
              labelStyle: TextStyle(color: accentColor, fontSize: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: BorderSide(width: 1)),
              label: Text(widget.choices[index]),
              selected: _value == index,
              onSelected: (bool selected) {
                setState(() {
                  _value = selected ? index : null;
                  _value != null ? selectedTransport = widget.choices[_value!] : null;
                });
              },
            ),
          );
        },
      ).toList(),
    );
  }
}
