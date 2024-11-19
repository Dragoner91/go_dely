

import 'package:go_dely/domain/entities/combo/combo.dart';
import 'package:go_dely/infraestructure/models/combo_db.dart';

class ComboMapper{

  static Combo comboToEntity(ComboDB comboDB) => 
    Combo(
      id: comboDB.id, 
      name: comboDB.name, 
      price: comboDB.price, 
      description: comboDB.description, 
      products: comboDB.products, 
      category: comboDB.category, 
      currency: comboDB.currency,
      imageUrl: comboDB.imageUrl
    ); 
}