import 'package:go_dely/domain/category/category.dart';
import 'package:go_dely/infraestructure/models/category_db.dart';

class CategoryMapper {
  static Category categoryToEntity(CategoryDB categoryDB) => 
    Category(
      id: categoryDB.id, 
      imageUrl: categoryDB.imageUrl, 
      name: categoryDB.name
    );
}