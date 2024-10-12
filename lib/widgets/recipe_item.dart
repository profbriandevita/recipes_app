import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_app/models/recipe.dart';
import 'package:recipes_app/providers/recipe_provider.dart';
import 'package:share_plus/share_plus.dart';

class RecipeItem extends StatelessWidget {
  final Recipe recipe;
  const RecipeItem({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(recipe.imageUrl),
        ),
        title: Text(recipe.title),
        subtitle: Text(recipe.description),
        trailing: Wrap(children: [
          IconButton(
            onPressed: () {
              //Logica para marcar como favorito
              recipeProvider.toggleFavorite(recipe.id);
            },
            icon: Icon(
              recipe.isFavorite
                  ? Icons.favorite_border_outlined
                  : Icons.favorite_border_outlined,
              color: recipe.isFavorite ? Colors.red : null,
            ),
          ),
          IconButton(
            onPressed: () {
              Share.share(
                'Mira esta receta: ${recipe.title}\n\nDescripcion: ${recipe.description}\nIngredientes: ${recipe.ingredients.join(', ')}',
              );
            },
            icon: const Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {
              recipeProvider.deleteRecipe(recipe.id);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ]),
      ),
    );
  }
}
