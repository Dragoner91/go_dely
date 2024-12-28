
class UserDB {

  final String email;
  final String fullname;
  final String image;
  final String password;
  final String phone;
  final String ci;

  UserDB({
    required this.email,
    required this.fullname, 
    required this.image,
    required this.password, 
    required this.phone, 
    required this.ci,  
  });
  

  factory UserDB.fromJson(Map<String, dynamic> json) => UserDB(
    email: json["email"].toString(), 
    image: json["image"],
    fullname: json["name"], 
    password: json["password"], 
    phone: json["phone"], 
    ci: json["ci"].toString(), 
    
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "image": image,
    "name": fullname,
    "password": password,
    "ci": ci,
  };
}