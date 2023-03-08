class Expense{
  String serviceID;
  String name;
  String objectID;
  String creatorID;
  String description;
  DateTime dateTimeInfo;
  String resolverid;

  Expense({required this.serviceID,required this.name, required this.objectID ,required this.creatorID,required this.description,required this.dateTimeInfo, required this.resolverid});

  factory Expense.fromJson(Map<String, dynamic> json){
    return Expense(
      serviceID: json['_id'],
      name: json['name'],
      objectID: json['objectID'],
      creatorID: json['creatorID'],
      description: json['description'],
      dateTimeInfo: DateTime.parse(json['dateTimeInfo']), 
      resolverid: json['resolverid'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': serviceID,
    'name': name,
    'objectID': objectID,
    'creatorID': creatorID,
    'description': description,
    'date_time_info': dateTimeInfo,
    'resolverid': resolverid,
  };
}