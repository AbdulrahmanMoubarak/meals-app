import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/meal.dart';

import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const ROUTE = '/category-meals';
  final List<Meal> availableMeals;

  const CategoryMealsScreen({
    Key? key,
    required this.availableMeals,
  }) : super(key: key);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late List<Meal> _categoryMeals;
  late String _categoryTitle;
  bool _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      _categoryTitle = routeArgs['title'] == null ? '' : routeArgs['title']!;
      final categoryId = routeArgs['id'];
      _categoryMeals = widget.availableMeals
          .where(
            (element) => element.categories.contains(categoryId),
          )
          .toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(_categoryTitle)),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return MealItem(
              id: _categoryMeals[index].id,
              title: _categoryMeals[index].title,
              imageUrl: _categoryMeals[index].imageUrl,
              duration: _categoryMeals[index].duration,
              complexity: _categoryMeals[index].complexity,
              affordability: _categoryMeals[index].affordability,
            );
          },
          itemCount: _categoryMeals.length,
        ));
  }
}
