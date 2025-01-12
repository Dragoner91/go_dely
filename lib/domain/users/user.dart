class User{

  final String? ci;
  final String? image;
  final String fullname;
  final String phone;
  final String email;
  final String? password;
  final String? type;
  

 User({
  this.ci,
  this.image,
  required this.fullname,
  required this.phone, 
  required this.email, 
  this.password,
  this.type,
  });
}