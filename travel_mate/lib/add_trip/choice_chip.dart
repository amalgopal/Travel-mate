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
    const Icon(Icons.flight_takeoff_rounded),
   const Icon(Icons.directions_car_rounded),
   const Icon(Icons.train_rounded),
   const Icon(Icons.directions_bike_rounded),
   const Icon(Icons.directions_boat),
   const Icon(Icons.commute),
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
          return SizedBox(
            height: 50,
            width: 112,
            child: ChoiceChip(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              avatar: widget.icons[index],
              selectedColor: primaryColor,
              backgroundColor: backgroundColor,
              iconTheme: const IconThemeData(
                color: accentColor,
                size: 17,
              ),
              labelStyle:const TextStyle(color: accentColor, fontSize: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side:const BorderSide(width: 1)),
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
