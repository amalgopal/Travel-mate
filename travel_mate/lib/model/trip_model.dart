 

import 'package:travel_mate/model/companions_model.dart';

class TripModal {
  int? id;
  final String? coverPic;
  final String tripName;
  final String destination;
  final String budget;
  final String startingDate;
  final String endingDate;
  late final String transport;
  final String travelPurpose;
  final int? userID;
  List<CompanionModel> companions;

  TripModal({
    required this.tripName,
    required this.destination,
    required this.budget,
    required this.startingDate,
    required this.endingDate,
    required this.transport,
    required this.travelPurpose,
    this.coverPic,
    this.id,
    required this.userID,
    this.companions = const [],
  });

  static TripModal fromJson(map) {
    return TripModal(
        id: map['id'],
        coverPic: map['coverPic'],
        tripName: map['tripName'],
        destination: map['destination'],
        budget: map['budget'],
        startingDate: map['startingDate'],
        endingDate: map['endingDate'],
        transport: map['transport'],
        travelPurpose: map['travelPurpose'],
        userID: map['userID']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tripName': tripName,
      'destination': destination,
      'budget': budget,
      'startingDate': startingDate,
      'endingDate': endingDate,
      'transport': transport,
      'travelPurpose': travelPurpose,
      'coverPic': coverPic,
      'userID': userID,
    };
  }
}
