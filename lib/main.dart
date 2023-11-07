import 'package:pizza_app/common/theme/theme_builder.dart';
import 'package:pizza_app/data/repository/pizza_repository.dart';
import 'package:pizza_app/data/repository/pizza_repository_impl.dart';
import 'package:pizza_app/features/admin/home/admin_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/features/admin/management/pizza_bloc/pizza_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PizzaRepository _pizzaRepository =
      PizzaRepositoryImpl();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => _pizzaRepository,
      child: BlocProvider(
        create: (_) => PizzaBloc(_pizzaRepository)
          ..add(const FetchPizzas()),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeBuilder.getThemeData(),
          home: const HomePage(),
        ),
      ),
    );
  }
}
