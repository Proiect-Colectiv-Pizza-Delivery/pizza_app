import 'package:pizza_app/common/theme/theme_builder.dart';
import 'package:pizza_app/data/domain/user.dart';
import 'package:pizza_app/data/repository/ingredients/ingredient_repository.dart';
import 'package:pizza_app/data/repository/ingredients/ingredient_repository_impl.dart';
import 'package:pizza_app/data/repository/pizza/pizza_repository.dart';
import 'package:pizza_app/data/repository/pizza/pizza_repository_impl.dart';
import 'package:pizza_app/features/admin/home/admin_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/features/admin/management/ingredient/ingredient_bloc/ingredient_bloc.dart';
import 'package:pizza_app/features/admin/management/pizza/pizza_bloc/pizza_bloc.dart';
import 'package:pizza_app/features/user/profile/user_bloc.dart/user_bloc.dart';
import 'package:pizza_app/features/user/user_root_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static bool admin = false;
  final PizzaRepository _pizzaRepository = PizzaRepositoryImpl();
  final IngredientRepository _ingredientRepository = IngredientRepositoryImpl();
  final User _user = const User(
      firstName: "Emil",
      lastName: "Yung",
      email: "emil_yung@gmail.com",
      username: "eyung",
      phoneNumber: "+40758978965");
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
          BlocProvider(create: (_) => UserBloc(_user)..add(const FetchUser()))
        ],
        child: MaterialApp(
          title: 'Slice2You',
          theme: ThemeBuilder.getThemeData(),
          home: MyApp.admin ? const HomePage() : const UserRootScreen(),
        ),
      ),
    );
  }
}
