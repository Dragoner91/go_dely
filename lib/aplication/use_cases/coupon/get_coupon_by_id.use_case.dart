

import 'package:go_dely/core/result.dart';
import 'package:go_dely/core/use_case.dart';
import 'package:go_dely/domain/users/i_auth_repository.dart';
import 'package:go_dely/infraestructure/datasources/petitions/i_petition.dart';

class GetCouponByIdDto {

  final String id;

  GetCouponByIdDto(this.id);

}

class GetCouponByIdUseCase extends IUseCase<GetCouponByIdDto, double> {

  final IPetition petition;
  final IAuthRepository auth;

  GetCouponByIdUseCase({ required this.auth, required this.petition});

  @override
  Future<Result<double>> execute(GetCouponByIdDto dto) async {
    final tokenResult = await auth.getToken();
    if (tokenResult.isError) return throw tokenResult.error;

    petition.updateHeaders(headerKey: "Authorization", headerValue: "Bearer ${tokenResult.unwrap()}");

    final result = await petition.makeRequest(
      urlPath: '/cupon/one/by/${dto.id}',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        double amount = double.parse(data['amount'].toString());
        return amount;
      },
    );

    return result;
    
  }

}