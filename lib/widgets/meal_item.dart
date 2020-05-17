import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared_widgets/gestureDetector.dart';
import '../screens/meal_detail_screen.dart';
import '../model/meal.dart';

class MealItem extends StatelessWidget {
  final String catogoryId;
  // final Meal meal;

  MealItem({
    //   this.meal,
    this.catogoryId,
  });
  @override
  Widget build(BuildContext context) {
    final loadedMeal = Provider.of<Meal>(context);
    // print(meal.title);

    void _selectMeal(BuildContext context) {
      Navigator.of(context).pushNamed(MealDetailScreen.routeName, arguments: {
        'catogoryId': catogoryId,
        'mealId': loadedMeal.id,
      });
    }

    return BuidGetureDetector(
      loadedMeal: loadedMeal,
      function: _selectMeal,
    );
  }
}