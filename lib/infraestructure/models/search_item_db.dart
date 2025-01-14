class SearchItem {
  
  final String id;
  final String name;
  final String type;

  SearchItem({required this.id, required this.name, required this.type});

}


class SearchItemDb {
  final String id;
  final String name;
  final String type;

  SearchItemDb({required this.id, required this.name, required this.type});

  factory SearchItemDb.fromJson(Map<String, dynamic> json) {
    return SearchItemDb(
      id: json['id'], 
      name: json['name'], 
      type: json['type']
    );
  }


}