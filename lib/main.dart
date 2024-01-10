import 'package:pizza_app/common/theme/theme_builder.dart';
import 'package:pizza_app/data/repository/ingredients/ingredient_repository.dart';
import 'package:pizza_app/data/repository/ingredients/ingredient_repository_impl.dart';
import 'package:pizza_app/data/repository/pizza/pizza_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/data/repository/pizza/pizza_repository_online.dart';
import 'package:pizza_app/features/admin/management/ingredient/ingredient_bloc/ingredient_bloc.dart';
import 'package:pizza_app/features/admin/management/pizza/pizza_bloc/pizza_bloc.dart';
import 'package:pizza_app/features/common/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PizzaRepository _pizzaRepository = PizzaRepositoryOnline();
  final IngredientRepository _ingredientRepository = IngredientRepositoryImpl();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => _pizzaRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) =>
                  PizzaBloc(_pizzaRepository)..add(const FetchPizzas())),
          BlocProvider(
              create: (_) => IngredientBloc(_ingredientRepository)
                ..add(const FetchIngredients())),
        ],
        child: MaterialApp(
          title: 'Slice2You',
          theme: ThemeBuilder.getThemeData(),
          home: const WelcomeScreen(),
        ),
      ),
    );
  }
}
