class Category{

  final String id;
  final String name;
  final String imageUrl;

 Category({required this.id, required this.imageUrl, required this.name});

}

class GetCategoryByIdDto {
  
  final String id;

  GetCategoryByIdDto(this.id);

}

class GetCategoriesDto {
  
}

