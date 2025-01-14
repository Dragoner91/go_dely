import 'package:go_dely/infraestructure/models/search_item_db.dart';

class SearchItemMapper {

  static SearchItem searchItemToEntity(SearchItemDb searchItemDb) => 
    SearchItem(
      id: searchItemDb.id, 
      name: searchItemDb.name, 
      type: searchItemDb.type
    );
}