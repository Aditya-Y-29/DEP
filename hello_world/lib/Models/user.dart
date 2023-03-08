class User{
  String userID;
  String name;
  String username;
  String email;
  String phoneNo;

  User({required this.userID,required this.name, required this.username ,required this.email,required this.phoneNo});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      userID: json['_id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phoneNo: json['phoneNo'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': userID,
    'name': name,
    'username': username,
    'email': email,
    'phoneNo': phoneNo,
  };
}