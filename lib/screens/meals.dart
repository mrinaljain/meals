import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {super.key,
      required this.title,
      required this.meals,
     });

  final String title;
  final List<Meal> meals;

  void _selectMeal(BuildContext context, Meal meal) {
    MaterialPageRoute route = MaterialPageRoute(builder: (ctx) {
      return MealDetail(
        meal: meal,
      );
    });
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (BuildContext context, int index) {
        return MealItem(
          meal: meals[index],
          onSelectMeal: _selectMeal,
        );
        // return Text(meals[index].title);
      },
    );
    if (meals.isEmpty) {
      content = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Uhh ohh... Nothing Here',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text('Try Selecting a diffrent category')
        ],
      );
    }
    if (title == 'favourite') return content;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: content,
    );
  }
}
