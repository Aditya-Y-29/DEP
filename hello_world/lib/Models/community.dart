class Community{
  String communityID;
  String name; 
  String creatorID;

  Community({required this.communityID,required this.name, required this.creatorID});

  factory Community.fromJson(Map<String, dynamic> json){
    return Community(
      communityID: json['_id'],
      name: json['name'],
      creatorID: json['creatorID'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': communityID,
    'name': name,
    'creatorID': creatorID,
  };
}