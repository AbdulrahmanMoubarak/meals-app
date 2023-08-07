import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/data/dummy_data.dart';

class MealDetailsScreen extends StatelessWidget {
  static const ROUTE = '/meal-details';
  final Function toggleFavourite;
  final Function isfavourite;
  const MealDetailsScreen(
      {Key? key, required this.toggleFavourite, required this.isfavourite})
      : super(key: key);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
    );
  }

  Widget buildContainer(BuildContext context, {required Widget child}) {
    return Container(
      height: 150,
      width: 300,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final mealId = routeArgs['id'];
    final meal = DUMMY_MEALS.firstWhere((element) => element.id == mealId);
    return Scaffold(
      appBar: AppBar(title: Text('${meal.title}')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              context,
              child: ListView.builder(
                itemCount: meal.ingredients.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Card(
                      color: Colors.yellowAccent,
                      child: Text(meal.ingredients[index]),
                    ),
                  );
                },
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(context,
                child: ListView.builder(
                  itemBuilder: (context, index) => Column(children: [
                    ListTile(
                      leading: CircleAvatar(child: Text('# ${index + 1}')),
                      title: Text(meal.steps[index]),
                    ),
                    Divider()
                  ]),
                  itemCount: meal.steps.length,
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child:
            Icon(isfavourite(mealId) ? Icons.favorite : Icons.favorite_border),
        onPressed: () {
          toggleFavourite(mealId);
        },
      ),
    );
  }
}
