

import 'package:go_dely/domain/combo/combo.dart';
import 'package:go_dely/infraestructure/models/combo_db.dart';

class ComboMapper{

  static Combo comboToEntity(ComboDB comboDB) => 
    Combo(
      id: comboDB.id, 
      name: comboDB.name, 
      price: comboDB.price, 
      description: comboDB.description, 
      products: comboDB.products, 
      categories: comboDB.categories, 
      currency: comboDB.currency,
      imageUrl: comboDB.imageUrl,
      discount: comboDB.discount,
    ); 
}