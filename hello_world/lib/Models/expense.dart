class Expense{
  String expenseID;
  String name;
  String objectID;
  String creatorID;
  String amount;
  String description;
  DateTime dateTimeInfo;
  String resolverid;

  Expense({required this.expenseID,required this.name, required this.objectID ,required this.creatorID,required this.amount,required this.description,required this.dateTimeInfo, required this.resolverid});

  factory Expense.fromJson(Map<String, dynamic> json){
    return Expense(
      expenseID: json['_id'],
      name: json['name'],
      objectID: json['objectID'],
      creatorID: json['creatorID'],
      amount: json['amount'],
      description: json['description'],
      dateTimeInfo: DateTime.parse(json['dateTimeInfo']), 
      resolverid: json['resolverid'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': expenseID,
    'name': name,
    'objectID': objectID,
    'creatorID': creatorID,
    'amount': amount,
    'description': description,
    'date_time_info': dateTimeInfo,
    'resolverid': resolverid,
  };
}