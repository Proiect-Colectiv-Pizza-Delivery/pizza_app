import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pizza_app/common/theme/colors.dart';
import 'package:pizza_app/common/widgets/default_button.dart';
import 'package:pizza_app/common/widgets/dialogs.dart';
import 'package:pizza_app/common/widgets/rounded_container.dart';
import 'package:pizza_app/data/domain/order.dart';
import 'package:pizza_app/data/domain/pizza.dart';
import 'package:pizza_app/features/user/cart/bloc/cart_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderPage extends StatelessWidget {
  final Order order;
  const OrderPage({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          order.isPickUp ? "Pick Order" : "Delivery Order",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  (order.isPickUp ? "Picked-up " : "Delivered ") +
                      DateFormat("dd MMM yyyy - HH:mm").format(order.date),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              for (Pizza pizza in order.pizzas.keys)
                ListTile(
                  leading: Text("${order.pizzas[pizza]} X"),
                  title: Text(pizza.name),
                  subtitle: Text(pizza.ingredientsString()),
                  trailing: Text("${pizza.price} \$"),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: _priceSection(context, order.pizzas, order.totalPrice),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _deliveryAddressSection(context),
              ),
              _buttonSection(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonSection(BuildContext context) {
    return RoundedContainer(
      hasAllCornersRounded: true,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: DefaultButton(
              onPressed: () {
                NativeDialog(
                  title: "Order Again",
                  content:
                      "Are you sure you want to order these pizzas again? This action will replace the current content of your cart with the pizzas from this order.",
                  firstButtonText: "Cancel",
                  secondButtonText: "Ok",
                  onSecondButtonPress: () {
                    // remove old dialog button
                    Navigator.of(context).pop();

                    // set the contents of the cart to the order's contents
                    BlocProvider.of<CartBloc>(context).add(SubstituteCart(
                        order.pizzas, <String, String>{
                      order.addressLineOne!: order.addressLineTwo ?? ""
                    }));
                    NativeDialog(
                      title: "Success",
                      content:
                          "Your cart's content's have been successfully replaced with the ones from the order. Please make sure the delivery address is correct before finalizing the order.",
                      firstButtonText: "Ok",
                      onFirstButtonPress: () {
                        // go back to the order screen
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ).showOSDialog(context);
                  },
                ).showOSDialog(context);
              },
              text: "Order again",
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
            child: DefaultButton(
              color: AppColors.surface,
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: AppColors.black),
              onPressed: () {
                launchUrl(Uri.parse("tel://+40758784878"));
              },
              text: "Get Help",
            ),
          ),
        ],
      ),
    );
  }

  Widget _deliveryAddressSection(BuildContext context) {
    return RoundedContainer(
      hasAllCornersRounded: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  order.isPickUp ? "Pick-up location" : "Delivery Address",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: AppColors.primary),
                ),
              ],
            ),
            ListTile(
              horizontalTitleGap: 4,
              leading: const Icon(
                Icons.location_on_outlined,
                color: AppColors.black,
              ),
              title: order.isPickUp
                  ? const Text("Strada Paris 18")
                  : Text(order.addressLineOne!),
              subtitle: order.addressLineTwo != null && !order.isPickUp
                  ? Text(order.addressLineTwo!)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceSection(
      BuildContext context, Map<Pizza, int> pizzaMapping, totalPrice) {
    double pizzaPrice = 0;
    pizzaMapping.forEach((key, value) => pizzaPrice += value * key.price);
    return RoundedContainer(
      color: AppColors.white,
      hasAllCornersRounded: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            priceRow(context, "Discount", pizzaPrice * 0.3),
            priceRow(context, "Subtotal", pizzaPrice.toDouble(),
                fontWeight: FontWeight.w800),
            if (!order.isPickUp) priceRow(context, "Delivery fee", 4),
            priceRow(context, "Tips",
                totalPrice - pizzaPrice - (!order.isPickUp ? 4 : 0)),
            const Divider(
              indent: 40,
              endIndent: 40,
            ),
            priceRow(context, "Total", (totalPrice),
                fontWeight: FontWeight.w800),
          ],
        ),
      ),
    );
  }

  Widget priceRow(BuildContext context, String text, double price,
      {FontWeight? fontWeight}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: fontWeight),
        ),
        const Spacer(),
        Text(
          "${price.toStringAsFixed(1)} \$",
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: fontWeight),
        ),
      ]),
    );
  }
}
