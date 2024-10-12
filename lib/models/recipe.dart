class Recipe {
  final String id;
  final String title;
  final String description;
  final List<String> ingredients;
  final String imageUrl;
  bool isFavorite;

  Recipe(
      {required this.id,
      required this.title,
      required this.description,
      required this.ingredients,
      required this.imageUrl,
      this.isFavorite = false});
}
