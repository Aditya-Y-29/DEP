class Expense{
  String? objectID;
  String? userID;
  int? amount;
  String? description;
  DateTime? date;

  Expense({this.objectID, this.userID, this.amount, this.description, this.date});

  factory Expense.fromMap(Map<String, dynamic> json) {
    return Expense(
      objectID: json['objectID'],
      userID: json['userID'],
      amount: int.parse(json['amount']),
      description: json['description'],
      date: DateTime.parse(json['expenseDate']),
    );
  }

  Map<String,dynamic> toMap() {
    return <String, dynamic>{
      'objectID': objectID,
      'userID': userID,
      'amount': amount,
      'description': description,
      'expenseDate': date!.toIso8601String()
    };
  }
}