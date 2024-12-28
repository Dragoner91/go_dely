import 'package:go_dely/domain/users/user.dart';
import 'package:go_dely/infraestructure/models/user_db.dart';

class UserMapper{

  static User userToEntity(UserDB userDB) => 
    User(
      ci: userDB.ci, 
      fullname: userDB.fullname, 
      image: userDB.image,
      phone: userDB.phone,
      email: userDB.email,
      password: userDB.password
    ); 
    
   }
