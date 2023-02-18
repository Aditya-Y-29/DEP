class Service{
  String? objectID;
  String? userID;
  String? description;
  DateTime? date;

  Service({this.objectID, this.userID, this.description, this.date});

  factory Service.fromMap(Map<String, dynamic> json) {
    return Service(
      objectID: json['objectID'],
      userID: json['userID'],
      description: json['description'],
      date: DateTime.parse(json['serviceDate']),
    );
  }

  Map<String,dynamic> toMap() {
    return <String, dynamic>{
      'objectID': objectID,
      'userID': userID,
      'description': description,
      'serviceDate': date!.toIso8601String()
    };
  }
}