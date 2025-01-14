import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/users/i_auth_repository.dart';
import 'package:go_dely/infraestructure/datasources/petitions/i_petition.dart';
import 'package:go_dely/infraestructure/mappers/search_item_mapper.dart';
import 'package:go_dely/infraestructure/models/search_item_db.dart';

class SearchRepository {
  final IPetition petition;
  final IAuthRepository auth;

  SearchRepository({required this.petition, required this.auth});

  Future<Result<List<SearchItem>>> getItemsForSearch() async {
    final tokenResult = await auth.getToken();
    if(tokenResult.isError) return throw tokenResult.error;

    petition.updateHeaders(headerKey: "Authorization", headerValue: "Bearer ${tokenResult.unwrap()}");
    final result = await petition.makeRequest(
      urlPath: '/product/summary',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        List<SearchItem> items = [];
        for (var item in data) {
          items.add(
            SearchItemMapper.searchItemToEntity(
              SearchItemDb.fromJson(item)
            )
          );
        }
        return items;
      },
    );
    return result;
  }
}