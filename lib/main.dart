import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/data/dummy_data.dart';
import 'package:flutter_complete_guide/models/meal.dart';
import 'package:flutter_complete_guide/screens/category_meals_screen.dart';
import 'package:flutter_complete_guide/screens/filters_screen.dart';
import 'package:flutter_complete_guide/screens/meal_details_screen.dart';
import 'package:flutter_complete_guide/screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];
  Map<String, bool> _filters = {
    'gluten': false,
    'vegan': false,
    'vegetarian': false,
    'lactose': false
  };

  bool _isMealFavourite(String id) {
    return _favouriteMeals.any((element) => id == element.id);
  }

  void _toggleFavourite(String mealId) {
    setState(() {
      final idx = _favouriteMeals.indexWhere((element) => mealId == element.id);
      if (idx >= 0) {
        _favouriteMeals.removeAt(idx);
      } else {
        _favouriteMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      }
    });
  }

  void _setFilters(Map<String, bool> setFilters) {
    setState(() {
      _filters = setFilters;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodySmall: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                bodyMedium: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                titleSmall: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    color: Color.fromRGBO(20, 51, 51, 1),
                    fontWeight: FontWeight.bold),
                titleMedium: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    color: Color.fromRGBO(20, 51, 51, 1),
                    fontWeight: FontWeight.bold),
              )),
      routes: {
        '/': (ctx) => TabsScreen(favMeals: _favouriteMeals),
        CategoryMealsScreen.ROUTE: (ctx) =>
            CategoryMealsScreen(availableMeals: _availableMeals),
        MealDetailsScreen.ROUTE: (ctx) => MealDetailsScreen(
            toggleFavourite: _toggleFavourite, isfavourite: _isMealFavourite),
        FiltersScreen.ROUTE: (ctx) =>
            FiltersScreen(saveFilters: _setFilters, filters: _filters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (ctx) => TabsScreen(
                  favMeals: _favouriteMeals,
                ));
      },
    );
  }
}
