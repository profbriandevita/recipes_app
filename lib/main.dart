import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_app/providers/recipe_provider.dart';
import 'package:recipes_app/screens/recipes_list_screen.dart';
import 'package:recipes_app/themes/theme.dart';

void main() => runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => RecipeProvider())],
      child: const MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Aplicacion de Recetas',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const RecipesListScreen());
  }
}
