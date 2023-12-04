class ExpenseModel {
  int? id;
  String spende;
  int amount;
  int tripID;
  int userId;

  ExpenseModel(
    {this.id, 
    required this.spende, 
    required this.amount, 
    required this.tripID,
    required this.userId});

    static ExpenseModel fromJson (map){
      return ExpenseModel(
        spende: map['spende'],
         amount: map['amount'],
          tripID: map['tripId'],
           userId: map['userId']);
    }
   
   Map<String,dynamic> toMap(){
    return{
      'id' : id,
      'spende' : spende,
      'amount' : amount,
      'tripID' : tripID,
      'userId' : userId,
    };
   }
}