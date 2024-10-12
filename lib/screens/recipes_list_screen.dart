import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_app/providers/recipe_provider.dart';
import 'package:recipes_app/screens/add_recipe_screen.dart';
import 'package:recipes_app/widgets/recipe_item.dart';

class RecipesListScreen extends StatefulWidget {
  const RecipesListScreen({super.key});

  @override
  State<RecipesListScreen> createState() => _RecipesListScreenState();
}

class _RecipesListScreenState extends State<RecipesListScreen> {
  bool _showFavoritesOnly = false;
  String _searchQuery = '';
  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    final recipes = _showFavoritesOnly
        ? recipeProvider.favoriteRecipes
        : recipeProvider.recipes.where((recipe) {
            final loweQuery = _searchQuery.toLowerCase();
            return recipe.title.toLowerCase().contains(loweQuery) ||
                recipe.ingredients.any((ingredient) =>
                    ingredient.toLowerCase().contains(loweQuery));
          }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recetas de Cocina 🍲'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _showFavoritesOnly = !_showFavoritesOnly;
              });
            },
            icon: Icon(
                _showFavoritesOnly ? Icons.favorite : Icons.favorite_border),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Buscar Recetas...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
            ),
          ),
          Expanded(
              child: recipes.isEmpty
                  ? const Center(child: Text('No se encontraron recetas'))
                  : ListView.builder(
                      itemCount: recipes.length,
                      itemBuilder: (context, index) {
                        return RecipeItem(recipe: recipes[index]);
                      },
                    ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddRecipeScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
