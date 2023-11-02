import 'package:pizza_app/common/theme/theme_builder.dart';
import 'package:pizza_app/data/repository/pizza_repository.dart';
import 'package:pizza_app/data/repository/discount_code_repository_impl.dart';
import 'package:pizza_app/data/repository/discount_code_repository_local.dart';
import 'package:pizza_app/discount_management_screens/discount_bloc/pizza_bloc.dart';
import 'package:pizza_app/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PizzaRepository _discountCodeRepository =
      PizzaRepositoryImpl();

  // final PizzaRepository _discountCodeRepositoryLocal =
  //     PizzaRepositoryLocal();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => _discountCodeRepository,
      child: BlocProvider(
        create: (_) => PizzaBloc(_discountCodeRepository)
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
