


import 'package:go_dely/domain/discount/discount.dart';
import 'package:go_dely/infraestructure/models/discount_db.dart';

class DiscountMapper {

  static Discount discountToEntity(DiscountDB discountDB) =>
    Discount(
      name: discountDB.name,
      description: discountDB.description,
      endDate: discountDB.endDate,
      id: discountDB.id,
      imageUrl: discountDB.imageUrl,
      percentage: discountDB.percentage,
      startDate: discountDB.startDate
    );
}