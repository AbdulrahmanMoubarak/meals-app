import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  final Function saveFilters;
  final Map<String, bool> filters;
  const FiltersScreen({
    Key? key,
    required this.saveFilters,
    required this.filters,
  }) : super(key: key);
  static const ROUTE = '/filters';

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegan = false;
  bool _vegetarian = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.filters['gluten']!;
    _vegan = widget.filters['vegan']!;
    _vegetarian = widget.filters['vegetarian']!;
    _lactoseFree = widget.filters['lactose']!;
    super.initState();
  }

  Widget _buildSwitchListTile(
      String title, String subtitle, bool value, Function updateValue) {
    return SwitchListTile(
        title: Text(title),
        value: value,
        subtitle: Text(subtitle),
        onChanged: (val) => updateValue(val));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Filters'),
          actions: [
            IconButton(
                onPressed: () {
                  widget.saveFilters({
                    'gluten': _glutenFree,
                    'vegan': _vegan,
                    'vegetarian': _vegetarian,
                    'lactose': _lactoseFree
                  });
                },
                icon: Icon(Icons.save))
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal preferences',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                _buildSwitchListTile(
                    'Gluten free', 'Only show gluten-free meals', _glutenFree,
                    (val) {
                  setState(() {
                    _glutenFree = val;
                  });
                }),
                _buildSwitchListTile(
                    'Vegetarian', 'Only show vegetarian meals', _vegetarian,
                    (val) {
                  setState(() {
                    _vegetarian = val;
                  });
                }),
                _buildSwitchListTile('Vegan', 'Only show vegan meals', _vegan,
                    (val) {
                  setState(() {
                    _vegan = val;
                  });
                }),
                _buildSwitchListTile('Lactose free',
                    'Only show lactose-free meals', _lactoseFree, (val) {
                  setState(() {
                    _lactoseFree = val;
                  });
                })
              ],
            ))
          ],
        ));
  }
}
