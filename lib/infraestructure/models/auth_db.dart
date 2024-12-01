class AuthDB {

  final String email;
  final String fullname;
  final String password;
  final String phone;
  final String ci;
  final String token;

  AuthDB({
    
    required this.email,
    required this.fullname, 
    required this.password, 
    required this.phone, 
    required this.ci, 
    required this.token 
  });
  

  factory AuthDB.fromJson(Map<String, dynamic> json) => AuthDB(
    email: json["email"].toString(), 
    fullname: json["name"], 
    password: json["password"], 
    phone: json["phone"], 
    ci: json["ci"].toString(), 
    token: json["token"]
    
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "name": fullname,
    "password": password,
    "ci": ci,
    "token": token,
  };
}