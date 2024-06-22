import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screen/categories_screen.dart';
import 'package:meals_app/screen/meals_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeal = [];

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });  
  }

  void _toogleMealFavoriteStatus(Meal meal) {
    final isExiting = _favoriteMeal.contains(meal);

    if (isExiting) {
      setState(() {
        _favoriteMeal.remove(meal);
      });
      _showInfoMessage("Remove from favorite");
    } else {
      setState(() {
        _favoriteMeal.add(meal);
      });
      _showInfoMessage("Add to favorite");
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toogleMealFavoriteStatus,
    );
    var activePageTitle = "Categories";

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
          meals: _favoriteMeal,
          onToggleFavorite: _toogleMealFavoriteStatus,
        );
      activePageTitle = "Your Favorites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
        ],
      ),
    );
  }
}
