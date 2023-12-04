import 'package:flutter/material.dart';

import 'package:travel_mate/components/app_color.dart';
import 'package:travel_mate/custom_widge/budget_detail.dart';
import 'package:travel_mate/db/functions/db_function.dart';

import 'package:travel_mate/model/trip_model.dart';
import 'package:travel_mate/model/user_model.dart';

class DetailTab extends StatelessWidget {
  final UserModel user;
  final TripModal trip;
  DetailTab({Key? key, required this.user, required this.trip});
   

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenSize.height * 0.03,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Starting date',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 15.5),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.002,
                    ),
                    Text(
                      trip.startingDate,
                      style: TextStyle(color: accentColor3, fontSize: 13.5),
                    )
                  ],
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Ending date',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 15.5),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.002,
                    ),
                    Text(
                      trip.endingDate,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13.5,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BudgetContainer(
                    text: 'Budget',
                    budgetORexpenses: '₹ ${trip.budget}',
                  ),
                  FutureBuilder(
                    future: getTotalExpense(trip.id!),
                    builder: (context,snapshot) {
                      final total = snapshot.data;
                     // expense=int.parse(trip.budget)-(total??0);
                      
                      return BudgetContainer(
                        text: 'Expenses',
                        budgetORexpenses: '₹ $total',
                      );
                    }
                  ),
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              FutureBuilder(
                future: getbalance(trip.id!),
                builder: (context,snapshot) {
                 final balance = snapshot.data;
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: accentColor),
                        borderRadius: BorderRadius.circular(6)),
                    height: screenSize.height * 0.05,
                    width: screenSize.width * 0.9,
                    child: Center(
                        child: Text(
                      'Balance : ₹ $balance',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    )),
                  );
                }
              ),
              SizedBox(
                height: screenSize.height * 0.03,
              ),
              Row(
                children: [
                  Text(
                    'Travel purpose       ',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 15.5),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: accentColor2,
                        borderRadius: BorderRadius.circular(6)),
                    height: screenSize.height * 0.05,
                    width: screenSize.width * 0.3,
                    child: Center(
                        child: Text(
                      trip.travelPurpose,
                      style: TextStyle(color: accentColor3),
                    )),
                  )
                ],
              ),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              Divider(),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              Text(
                'Companions',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.5),
              ),
              Container(
                height: screenSize.height * 0.1,
                width: screenSize.width * 0.9,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: trip.companions.length,
                  itemBuilder: (context, index) {
                    final companion = trip.companions[index];
                    return Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 12, 20, 0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                maxRadius: 22,
                                child: Text(
                                  companion.name[0],
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              SizedBox(
                                height: screenSize.height * 0.006,
                              ),
                              Text(
                                companion.name,
                                style: TextStyle(fontSize: 13),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
