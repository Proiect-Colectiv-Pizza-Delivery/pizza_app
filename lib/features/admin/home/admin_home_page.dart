import 'package:pizza_app/common/theme/colors.dart';
import 'package:pizza_app/data/domain/pizza.dart';
import 'package:pizza_app/features/admin/management/pizza_bloc/pizza_bloc.dart';
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
  late List<Pizza> codes;
  @override
  void initState() {
    codes = Pizza.getPopulation();
    super.initState();
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
        body: BlocBuilder<PizzaBloc, PizzaState>(
          builder: (context, state) {
            if(state is! PizzaLoaded){
              return const Center(child: CircularProgressIndicator(),);
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Stack(
                children: [
                  ListView.separated(
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _addButton(),
                            ]),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
    );
  }

  Widget _addButton() {
    return GestureDetector(
      // onTap: () => Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (_) => PizzaFormScreen(
      //       type: PizzaFormType.add,
      //     ),
      //   ),
      // ),
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
