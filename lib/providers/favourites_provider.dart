import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

// 1. create a class with name  AbcNotifier which extends StateNotifier
// 2. if possible add a type in front of the statenotifier for exampler  <List<Meal>>
// 3. add constructor of the class AbcNotifier and give it a dummy value for example  AbcNotifier() :super([]);
// 4. now methods can be defined inside the class
// 5.  provider needs to be exported in the end
class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavouriteMealsNotifier() : super([]);

  bool toggleMealFavouriteStatus(Meal meal) {
    final bool isFavourite = state.contains(meal);
    // state = [];
    if (isFavourite) {
      // we are not removing the meal , insted we ae creting a new list and moving all the meals there other then the meal which is provided
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      /// used terniry operator to  add the provided meal to the existing state
      state = [...state, meal];
      return true;
    }
  }
}

final favouriteMealsProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>((ref) {
  return FavouriteMealsNotifier();
});
