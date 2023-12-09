import 'package:flutter/material.dart';


import 'package:travel_mate/components/app_color.dart';
import 'package:travel_mate/screen/add_trip.dart';

class MyDropdownMenu extends StatefulWidget {
  final List<String> items;
  final String initialValue;

  const MyDropdownMenu({Key? key,required this.items,required this.initialValue}) : super(key: key);

  @override
  State<MyDropdownMenu> createState() => _MyDropdownMenuState();
}

class _MyDropdownMenuState extends State<MyDropdownMenu> {
  String dropdownValue = '';

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 360,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: primaryColor),
          borderRadius: BorderRadius.circular(6)),
      child: DropdownButton(
        
        dropdownColor:cconst onst Color.fromARGB(255, 230, 230, 230),
        borderRadius: BorderRadius.circular(6),
        elevation: 0,
        padding:const EdgeInsets.symmetric(horizontal: 15),
        underline: const SizedBox(),
        isExpanded: true,
        value: dropdownValue,
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
            selectedTravelPurpose = dropdownValue;
          });
        },
        items: widget.items.map((String item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }
}
