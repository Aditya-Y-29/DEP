class UserModel{
  String name;
  String username;
  String email;
  String phoneNo;

  UserModel({required this.name, required this.username ,required this.email,required this.phoneNo});

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      name: json['Name'],
      username: json['UserName'],
      email: json['Email ID'],
      phoneNo: json['Phone Number'],
    );
  }

  Map<String, dynamic> toJson() => {
    'Name': name,
    'UserName': username,
    'Email ID': email,
    'Phone Number': phoneNo,
  };
}