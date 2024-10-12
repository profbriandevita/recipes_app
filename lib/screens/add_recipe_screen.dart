import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_app/models/recipe.dart';
import 'package:recipes_app/providers/recipe_provider.dart';
import 'package:uuid/uuid.dart';

class AddRecipeScreen extends StatefulWidget {
  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _imageUrlController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newRecipe = Recipe(
        id: Uuid().v4(), // Genera un ID único para cada receta
        title: _titleController.text,
        description: _descriptionController.text,
        ingredients: _ingredientsController.text
            .split(','), // Convierte ingredientes en una lista
        imageUrl: _imageUrlController.text,
      );

      // Guardar la receta en el RecipeProvider
      Provider.of<RecipeProvider>(context, listen: false).addRecipe(newRecipe);

      // Volver a la pantalla anterior
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Nueva Receta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration:
                    const InputDecoration(labelText: 'Título de la receta'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un título.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una descripción.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _ingredientsController,
                decoration: const InputDecoration(
                    labelText: 'Ingredientes (separados por comas)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese los ingredientes.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _imageUrlController,
                decoration:
                    const InputDecoration(labelText: 'URL de la Imagen'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la URL de la imagen.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Añadir Receta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
