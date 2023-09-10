import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.availableMeals});
 
  final List<Meal> availableMeals;
  final _dummyData = availableCategories;
 

  void _selectCategory(
      {required BuildContext context, required Category category}) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    /// Creat a material PAge rout to transfer
    MaterialPageRoute route = MaterialPageRoute(builder: (ctx) {
      return MealsScreen(
        title: category.title,
        meals: filteredMeals,
      
      );
    });

    Navigator.push(
      context,
      route,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemCount: _dummyData.length,
      itemBuilder: (BuildContext context, int index) {
        return CategoryGridItem(
          category: _dummyData[index],
          onSelectCategory: _selectCategory,
        );
      },
    );
  }
}
