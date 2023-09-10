import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

import 'package:meals/providers/favourites_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegeterian: false,
  Filter.vegan: false
};

/// Riverpod Changes the way stateclass are defined
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override

  /// Riverpod Changes the way stateclass are defined
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

/// Riverpod Changes the way stateclass are defined
class _TabsScreenState extends ConsumerState<TabsScreen> {
  int selectedPageIndex = 0;

  void changeTabs(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) {
            return const FilterScreen();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Filters logic is written below
    final availableMeals = ref.watch(filteredMealsProvider);
    Widget activeScreen = CategoriesScreen(
      availableMeals: availableMeals,
    );
    String pageTitle = ' Pick your category';
    if (selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(favouriteMealsProvider);
      activeScreen = MealsScreen(
        title: 'favourite',
        meals: favouriteMeals,
      );
      pageTitle = 'Favourite';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      drawer: MainDrawer(
        setScreen: _setScreen,
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          changeTabs(index);
        },
        currentIndex: selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Category'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favourite')
        ],
      ),
    );
  }
}
