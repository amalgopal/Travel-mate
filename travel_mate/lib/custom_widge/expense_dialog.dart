import 'package:flutter/material.dart';
import 'package:travel_mate/db/functions/db_function.dart';
import 'package:travel_mate/model/expense_model.dart';
import 'package:travel_mate/model/trip_model.dart';



   expenseDialog(BuildContext context,TripModal trip) { 
 
     // final formKey = GlobalKey<FormState>();
  final amountSpended = TextEditingController();
  final amount =TextEditingController();
    final Size screensize = MediaQuery.of(context).size;
    return SimpleDialog(
      
      title: const Text('Add Expense'),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  controller:amountSpended ,
                  decoration: const InputDecoration(
                    hintText: 'amount spended',
                    border: OutlineInputBorder()
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Enter amount spended';
                    }
                    return null;
                  },
                ),
                 SizedBox(
                  height: screensize.height * 0.02,
                ),
                TextFormField(
                  controller:amount ,
                  decoration: const InputDecoration(
                    hintText: 'amount',
                    border: OutlineInputBorder()
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Enter amount ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screensize.height * 0.03,),
                ElevatedButton(onPressed: (){
                  // if(formKey.currentState!.validate()){
                  //   addExpenses(amountSpended,amount);
                    
                  // }
                  addExpenses(amountSpended,amount,trip);
                  Navigator.of(context).pop(true);
                }, 
                child:const Text('Submit'))
              ],
            )
            ), 
        )
      ],
    );
  }
  
 Future<void> addExpenses(TextEditingController amountSpended, TextEditingController amount,TripModal trip) async{
 
    ExpenseModel obj= ExpenseModel(spende: amountSpended.text.trim(), amount: int.parse(amount.text.trim()), tripID:trip.id!, userId: trip.userID!);
     final expenseid = await addExpense(obj);
     obj.id =expenseid;
     
  }

