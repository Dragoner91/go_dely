class GetDiscountByIdDto {
  final String id;

  GetDiscountByIdDto(this.id);
}

class Discount {
  final String id;
  final String name;
  final String description;
  final double percentage;
  final String startDate;
  final String endDate;
  final String imageUrl;

  Discount({
    required this.id, 
    required this.name, 
    required this.description, 
    required this.percentage, 
    required this.startDate, 
    required this.endDate, 
    required this.imageUrl
  });
}