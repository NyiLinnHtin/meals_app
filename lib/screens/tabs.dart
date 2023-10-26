import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/providers/favourite_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.latosFree: false,
  Filter.vegetrian: false,
  Filter.vegan: false,
};

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int _selectedPageIndex = 0;

  //Change Tab
  void _changeSelectedPageIndex(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  //Change Screen From Drawer
  void _setScreenFromDrawer(String indentifier) async {
    if (indentifier == "Meals") {
      Navigator.of(context).pop();
    }
    //filter Screen
    else {
      Navigator.of(context).pop();
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: ((ctx) => const FiltersScreen())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final avaliableMeals = ref.watch(filterMealsProvider);

    Widget activeScreen = CategoriesScreen(
      avaliableMeals: avaliableMeals,
    );
    String activePageTitle = "Categories";

    if (_selectedPageIndex == 1) {
      final favouriteMeal = ref.watch(favouriteMealProvider);
      activeScreen = MealScreen(
        meals: favouriteMeal,
      );
      activePageTitle = "Your Favourites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreenFromDrawer),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _changeSelectedPageIndex,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.lunch_dining), label: "Category"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline), label: "Favourite")
        ],
      ),
    );
  }
}
