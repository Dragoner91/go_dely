import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/discount/discount.dart';
import 'package:go_dely/domain/discount/i_discount_repository.dart';
import 'package:go_dely/domain/users/i_auth_repository.dart';
import 'package:go_dely/infraestructure/datasources/petitions/i_petition.dart';
import 'package:go_dely/infraestructure/mappers/discount_mapper.dart';
import 'package:go_dely/infraestructure/models/discount_db.dart';

class DiscountRepositoryImpl implements IDiscountRepository {
  final IPetition petition;
  final IAuthRepository auth;

  DiscountRepositoryImpl({required this.auth, required this.petition});

  @override
  Future<Result<Discount>> getDiscountById(GetDiscountByIdDto dto) async {
    final tokenResult = await auth.getToken();
    if(tokenResult.isError) return throw tokenResult.error;

    petition.updateHeaders(headerKey: "Authorization", headerValue: "Bearer ${tokenResult.unwrap()}");

    final response = await petition.makeRequest(
      urlPath: '/discount/one/${dto.id}',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        final Discount discount = DiscountMapper.discountToEntity(
          DiscountDB.fromJson(data)
        );
        return discount;
      },
    );
    return response;
  }

}