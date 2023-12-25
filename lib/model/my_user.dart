class MyUser{
  static const String collectionName='users';
  String id;
  String firstname;
  String lastname;
  String Username;
  String email;

  MyUser({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.Username,
    required this.email
});
  MyUser.fromJson(Map<String,dynamic> json) :this(
    id: json['id'] as String,
    firstname: json['firstname'] as String,
    lastname: json['lastname'] as String,
    Username: json['Username'] as String,
    email: json['email'] as String

  );

  Map<String,dynamic> toJson(){
    return {
      'id' : id,
      'firstname' : firstname,
      'lastname' : lastname,
      'Username' : Username,
      'email' : email,
    };
  }
}