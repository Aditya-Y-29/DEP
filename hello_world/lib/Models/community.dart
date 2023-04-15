class CommunityModel{
  String name; 
  String phoneNo; // phone number of owner

  CommunityModel({required this.name, required this.phoneNo});

  factory CommunityModel.fromJson(Map<String, dynamic> json){
    return CommunityModel(
      name: json['Name'],
      phoneNo: json['Phone Number'],

    );
  }

  Map<String, dynamic> toJson() => {
    'Name': name,
    'Phone Number': phoneNo,
  };
}