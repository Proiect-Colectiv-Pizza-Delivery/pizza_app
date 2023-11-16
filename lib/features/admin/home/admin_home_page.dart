import 'package:pizza_app/common/theme/colors.dart';
import 'package:pizza_app/data/domain/ingredient.dart';
import 'package:pizza_app/data/domain/pizza.dart';
import 'package:pizza_app/features/admin/home/admin_ingredient_tile.dart';
import 'package:pizza_app/features/admin/management/ingredient/ingredient_bloc/ingredient_bloc.dart';
import 'package:pizza_app/features/admin/management/ingredient/ingredient_form.dart';
import 'package:pizza_app/features/admin/management/pizza/pizza_form.dart';
import 'package:pizza_app/features/admin/management/pizza/pizza_bloc/pizza_bloc.dart';
import 'package:pizza_app/features/admin/home/admin_pizza_tile.dart';
import 'package:pizza_app/profile/profile_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_pizza.dart';
part 'admin_ingredient.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pages = [const PizzaPage(), const IngredientPage()];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected tab index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Row(
          children: [
            const Text("Slice2You"),
            const Spacer(),
            GestureDetector(
              onTap: () => ProfileSheet.showAsModalBottomSheet(context),
              child: const Icon(Icons.person),
            )
          ],
        ),
      ),
      floatingActionButton: _addButton(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: "Pizza",
            icon: Icon(Icons.local_pizza_rounded),
          ),
          BottomNavigationBarItem(
            label: "Ingredient",
            icon: Icon(Icons.category_rounded),
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _addButton() {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => _selectedIndex == 0
              ? const PizzaForm(
                  type: PizzaFormType.add,
                )
              : const IngredientForm(type: IngredientFormType.add),
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
            color: AppColors.primary, shape: BoxShape.circle),
        child: const Padding(
          padding: EdgeInsets.all(12),
          child: Icon(
            Icons.add,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
