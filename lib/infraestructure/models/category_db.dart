class CategoryDB {

  final String id;
  final String name;
  final String imageUrl;

  CategoryDB({
    required this.id,
    required this.name, 
    required this.imageUrl 
  });
  

  factory CategoryDB.fromJson(Map<String, dynamic> json) => CategoryDB(
    id: json['id'],
    imageUrl: json['image'],
    name: json['name']
  );

  Map<String, dynamic> toJson() => {
    
  };
}