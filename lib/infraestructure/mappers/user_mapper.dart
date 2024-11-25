import 'package:go_dely/domain/entities/users/user.dart';
import 'package:go_dely/infraestructure/models/user_db.dart';

class UserMapper{

  static user userToEntity(UserDB UserDB) => 
    user(
      
      UserDB.ci, 
      UserDB.fullname, 
      UserDB.phone,
      UserDB.email,
      UserDB.password
      
      

    ); 
    
   }
