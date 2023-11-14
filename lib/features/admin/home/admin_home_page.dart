import 'package:pizza_app/common/theme/colors.dart';
import 'package:pizza_app/data/domain/ingredient.dart';
import 'package:pizza_app/data/domain/pizza.dart';
import 'package:pizza_app/features/admin/home/admin_ingredient_tile.dart';
import 'package:pizza_app/features/admin/management/ingredient/ingredient_bloc/ingredient_bloc.dart';
import 'package:pizza_app/features/admin/management/pizza/pizza_form.dart';
import 'package:pizza_app/features/admin/management/pizza/pizza_bloc/pizza_bloc.dart';
import 'package:pizza_app/features/admin/home/admin_pizza_tile.dart';
import 'package:pizza_app/profile/profile_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pages = [_PizzaPage(), _IngredientPage()];
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
            icon: Icon(
              Icons.abc, // Use a transparent icon
              color: Colors.transparent, // Set the color to transparent
            ),
          ),
          BottomNavigationBarItem(
            label: "Ingredient",
            icon: Icon(
              Icons.abc, // Use a transparent icon
              color: Colors.transparent, // Set the color to transparent
            ),
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
          builder: (_) => const PizzaForm(
            type: FormType.add,
          ),
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

class _PizzaPage extends StatefulWidget {
  @override
  State<_PizzaPage> createState() => _PizzaPageState();
}

class _PizzaPageState extends State<_PizzaPage> {
  late List<Pizza> codes;

  @override
  void initState() {
    codes = Pizza.getPopulation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PizzaBloc, PizzaState>(
      builder: (context, state) {
        if (state is! PizzaLoaded) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListView.separated(
            itemCount: state.codes.length,
            itemBuilder: (context, index) {
              return PizzaTile(
                pizza: state.codes[index],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                indent: 1,
                endIndent: 1,
                thickness: 1,
              );
            },
          ),
        );
      },
    );
  }
}

class _IngredientPage extends StatefulWidget {
  @override
  State<_IngredientPage> createState() => _IngredientPageState();
}

class _IngredientPageState extends State<_IngredientPage> {
  late List<Ingredient> ingredients;

  @override
  void initState() {
    ingredients = Ingredient.getPopulation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IngredientBloc, IngredientState>(
        builder: (context, state) {
      if (state is! IngredientLoaded) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView.separated(
          itemCount: state.ingredients.length,
          itemBuilder: (context, index) {
            return IngredientTile(
              ingredient: state.ingredients[index],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              indent: 1,
              endIndent: 1,
              thickness: 1,
            );
          },
        ),
      );
    });
  }
}
