import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pizza_app/common/theme/colors.dart';
import 'package:pizza_app/common/theme/text_stylers.dart';
import 'package:pizza_app/common/widgets/default_button.dart';
import 'package:pizza_app/common/widgets/rounded_container.dart';
import 'package:pizza_app/data/domain/pizza.dart';
import 'package:pizza_app/features/user/cart/bloc/cart_bloc.dart';

class PizzaSheet extends StatelessWidget {
  final Pizza pizza;
  final ScrollController scrollController;

  const PizzaSheet(
      {required this.pizza, required this.scrollController, super.key});

  static void showAsModalBottomSheet(BuildContext context, Pizza pizza) {
    DraggableScrollableController draggableScrollableController =
        DraggableScrollableController();
    showModalBottomSheet(
      backgroundColor: AppColors.transparent,
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return DraggableScrollableSheet(
          controller: draggableScrollableController,
          initialChildSize: 0.9,
          maxChildSize: 0.9,
          minChildSize: 0.3,
          builder: (BuildContext context, ScrollController scrollController) =>
              PizzaSheet(pizza: pizza, scrollController: scrollController),
        );
      },
    ).then((value) => draggableScrollableController.dispose());
  }

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  child: Image.asset(pizza.imagePath ?? "assets/pizza1.jpg"),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(pizza.name,
                          style: Theme.of(context).textTheme.titleLarge),
                      TextStyler.priceSection(context, pizza.price),
                      for (var ingredient in pizza.ingredients)
                        ListTile(
                          title: Text(ingredient.name),
                          subtitle: Text(ingredient.allergensString()),
                          trailing: SvgPicture.asset(
                              "assets/checked_radio_box_gray.svg"),
                        )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          AddSection(pizza: pizza)
        ],
      ),
    );
  }
}

class AddSection extends StatefulWidget {
  final Pizza pizza;
  const AddSection({required this.pizza, super.key});

  @override
  State<AddSection> createState() => _AddSectionState();
}

class _AddSectionState extends State<AddSection> {
  int _count = 1;

  void _increaseCount(){
    setState(() {
      _count += 1;
    });
  }

  void _decreaseCount(){
    setState(() {
      if(_count >= 2) {
        _count -= 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.tertiary,
            width: 0.3,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(
                color: AppColors.tertiary,
                width: 0.5,
              ),
            ),
            child: Row(
              children: [
                IconButton(onPressed: _decreaseCount, icon: const Icon(Icons.remove)),
                Text(_count.toString(), style: Theme.of(context).textTheme.labelLarge,),
                IconButton(onPressed: _increaseCount, icon: const Icon(Icons.add)),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 32),
              child: DefaultButton(onPressed: () {
                BlocProvider.of<CartBloc>(context).add(AddToCart(widget.pizza, _count));
              }, text: "Add"),
            ),
          ),
        ],
      ),
    );
  }
}
