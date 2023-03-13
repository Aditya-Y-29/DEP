class ObjectsModel{
  String? communityID;
  String creatorPhoneNo;
  String name;
  String? type;
  String? description;

  ObjectsModel({required this.communityID, required this.creatorPhoneNo ,required this.name,required this.type, required this.description});

  factory ObjectsModel.fromJson(Map<String, dynamic> json){
    return ObjectsModel(
      communityID: json['CommunityID'],
      creatorPhoneNo: json['CreatorPhoneNo'],
      name: json['Name'],
      type: json['Type'],
      description: json['Description'],
    );
  }

  Map<String, dynamic> toJson() => {
    'CommunityID': communityID,
    'CreatorPhoneNo': creatorPhoneNo,
    'Name': name,
    'Type': type,
    'Description': description,
  };
}