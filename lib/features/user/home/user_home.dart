import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/features/admin/management/pizza/pizza_bloc/pizza_bloc.dart';
import 'package:pizza_app/features/user/home/user_pizza_tile.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
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
            itemCount: state.pizzas.length,
            itemBuilder: (context, index) {
              return UserPizzaTile(
                pizza: state.pizzas[index],
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
