import 'package:flutter/material.dart';
import 'package:recipes_app/models/recipe.dart';

class RecipeProvider with ChangeNotifier {
  List<Recipe> _recipes = [];
  List<Recipe> get recipes => _recipes;

  void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
    notifyListeners();
  }

  List<Recipe> get favoriteRecipes =>
      _recipes.where((recipe) => recipe.isFavorite).toList();

  void deleteRecipe(String id) {
    _recipes.removeWhere((recipe) => recipe.id == id);
    notifyListeners();
  }

  void toggleFavorite(String id) {
    final index = _recipes.indexWhere((recipe) => recipe.id == id);
    if (index != -1) {
      _recipes[index].isFavorite = !_recipes[index].isFavorite;
      notifyListeners();
    }
  }
}
