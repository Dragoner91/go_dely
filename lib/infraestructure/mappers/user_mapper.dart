import 'package:go_dely/domain/entities/users/user.dart';
import 'package:go_dely/infraestructure/models/user_db.dart';

class UserMapper{

  static User userToEntity(UserDB UserDB) => 
    User(
      
      UserDB.ci, 
      UserDB.fullname, 
      UserDB.phone,
      UserDB.email,
      UserDB.password
      
      

    ); 
    
   }
