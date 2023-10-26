import 'package:flutter/material.dart';
import 'package:meals_app/screens/meal_detail.dart';
import 'package:meals_app/widgets/meal_item.dart';
import '../models/meal.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({
    super.key,
    this.title = "",
    required this.meals,
  });

  final String? title;
  final List<Meal> meals;

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((ctx) => MealDetailScreen(
              meal: meal,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Oh no.. Nothing Here!",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(height: 16),
            Text(
              "Please Try choosing other Category!",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
      );
    } else {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: ((ctx, index) => MealItem(
            meal: meals[index],
            onSelectMeal: ((meal) {
              _selectMeal(context, meal);
            }))),
      );
    }
    if (title != "") {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            title!,
            // style: const TextStyle(color: Colors.white),
          ),
        ),
        body: content,
      );
    } else {
      return content;
    }
  }
}
