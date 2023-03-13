class ServiceModel{
  String name;
  String objectID;
  String creatorID;
  String description;
  DateTime date;
  String resolverid;

  ServiceModel({required this.name, required this.objectID ,required this.creatorID,required this.description,required this.date, required this.resolverid});

  factory ServiceModel.fromJson(Map<String, dynamic> json){
    return ServiceModel(
      name: json['Name'],
      objectID: json['ObjectID'],
      creatorID: json['CreatorID'],
      description: json['Description'],
      date: json['Date'],
      resolverid: json['Resolverid'],
    );
  }

  Map<String, dynamic> toJson() => {
    'Name': name,
    'ObjectID': objectID,
    'CreatorID': creatorID,
    'Description': description,
    'Date': date,
    'Resolverid': resolverid,
  };
}