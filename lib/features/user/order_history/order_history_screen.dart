import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pizza_app/data/domain/order.dart';
import 'package:pizza_app/features/user/order_history/bloc/history_bloc.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(builder: (context, state) {
      return state is HistoryLoaded
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    for (Order order in state.orders) ...[
                      ListTile(
                        leading: Image.asset(
                            order.pizzas.keys.first.imagePath ??
                                "assets/pizza1.jpg"),
                        title: Text(
                          "${order.isPickUp ? "Pick-up Order" : "Delivery Order"} ${order.totalPrice}\$",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Text(
                          DateFormat("dd MMM yyyy - HH:mm").format(order.date),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      const Divider(
                        indent: 40,
                        endIndent: 40,
                      )
                    ]
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            );
    });
  }
}
