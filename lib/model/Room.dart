class Room{
  static const String collectionName='rooms';
  String id;
  String title;
  String description;
  String categoryid;

  Room({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryid
});
  Room.fromJson(Map<String,dynamic> json): this(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    categoryid: json['categoryId'] as String,
  );
  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'title':title,
      'description': description,
      'categoryId':categoryid
    };

  }

}