import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  latosFree,
  vegetrian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.latosFree: false,
          Filter.vegan: false,
          Filter.vegetrian: false,
        });

  void setAllFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void resetFilters() {
    state = {
      Filter.glutenFree: false,
      Filter.latosFree: false,
      Filter.vegan: false,
      Filter.vegetrian: false,
    };
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filterProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);

final filterMealsProvider = Provider((ref) {
  final meals = ref.watch(mealProvider);
  final activeFilters = ref.watch(filterProvider);

  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.latosFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetrian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
