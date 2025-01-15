class DiscountDB {
  final String id;
  final String name;
  final String description;
  final double percentage;
  final String startDate;
  final String endDate;
  final String imageUrl;

  DiscountDB({
    required this.id, 
    required this.name, 
    required this.description, 
    required this.percentage, 
    required this.startDate, 
    required this.endDate, 
    required this.imageUrl
  });

  factory DiscountDB.fromJson(Map<String, dynamic> json) {
    return DiscountDB(
      id: json['id'], 
      name: json['name'], 
      description: json['description'],
      endDate: json['deadline'],
      imageUrl: json['image'],
      percentage: json['percentage'],
      startDate: json['startDate']
    );
  }


}