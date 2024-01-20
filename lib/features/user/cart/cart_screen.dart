import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pizza_app/common/theme/colors.dart';
import 'package:pizza_app/common/theme/text_stylers.dart';
import 'package:pizza_app/common/widgets/default_button.dart';
import 'package:pizza_app/common/widgets/native_dialog.dart';
import 'package:pizza_app/common/widgets/rounded_container.dart';
import 'package:pizza_app/data/domain/pizza.dart';
import 'package:pizza_app/features/user/cart/add_address_sheet.dart';
import 'package:pizza_app/features/user/cart/bloc/cart_bloc.dart';
import 'package:pizza_app/features/user/page_bloc/root_page_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int pickupMethod = 0;
  int tips = 0;
  String? selectedAddress;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      double totalPrice = 0;
      state.cartMap.forEach((key, value) => totalPrice += value * key.price);
      if (selectedAddress == null) {
        if (state.address.keys.isNotEmpty) {
          selectedAddress = state.address.keys.first;
        }
      }
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              _methodSelectorSection(),
              for (Pizza pizza in state.cartMap.keys)
                ..._cartDeviceTile(
                  pizza,
                  state.cartMap[pizza]!,
                ),
              _addMoreSection(),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: _priceSection(totalPrice),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _tipsSection(),
              ),
              pickupMethod == 0
                  ? _deliveryAddressSection(state)
                  : _pickUpAddressSection(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: DefaultButton(
                  onPressed: state.cartMap.isNotEmpty &&
                          (selectedAddress != null || pickupMethod == 1)
                      ? () {
                          BlocProvider.of<CartBloc>(context).add(
                            ConfirmOrder(
                              addressLineOne: pickupMethod == 0
                                  ? selectedAddress!
                                  : "Strada Paris 18",
                              totalPrice: totalPrice +
                                  tips +
                                  (pickupMethod == 0 ? 4 : 0),
                              isPickup: pickupMethod == 1,
                            ),
                          );
                          NativeDialog(
                                  title: "Order Confirmed",
                                  content:
                                      "Thanks for choosing Slice2You! Our chefs are already preparing your delicious pizzas! ",
                                  firstButtonText: "Ok")
                              .showOSDialog(context);
                        }
                      : null,
                  text: "Confirm Order",
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _tipsSection() {
    Map<String, int> tipsMapping = {
      "No tips": 0,
      "2.00 \$": 2,
      "5.00 \$": 5,
      "10.00 \$": 10,
    };
    return RoundedContainer(
      hasAllCornersRounded: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Do we deserve a tip?",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (String element in tipsMapping.keys)
                  GestureDetector(
                    onTap: () => setState(() {
                      tips = tipsMapping[element]!;
                    }),
                    child: RoundedContainer(
                      hasAllCornersRounded: true,
                      color: tips == tipsMapping[element]
                          ? AppColors.primary
                          : AppColors.surface,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          element,
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: tips == tipsMapping[element]
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                        ),
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _pickUpAddressSection() {
    return RoundedContainer(
      hasAllCornersRounded: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Delivery Address",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: AppColors.primary),
                ),
              ],
            ),
            ListTile(
              horizontalTitleGap: 0,
              title: const Text("Strada Paris 18"),
              trailing: SvgPicture.asset("assets/checked_radio_box.svg"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _deliveryAddressSection(CartState state) {
    return RoundedContainer(
      hasAllCornersRounded: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Delivery Address",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: AppColors.primary),
                ),
              ],
            ),
            for (var address in state.address.keys)
              ListTile(
                horizontalTitleGap: 0,
                title: Text(address),
                trailing: address == selectedAddress
                    ? SvgPicture.asset("assets/checked_radio_box.svg")
                    : SvgPicture.asset("assets/empty_radio_box.svg"),
                subtitle: state.address[address] != null &&
                        state.address[address]!.isNotEmpty
                    ? Text(state.address[address]!)
                    : null,
                onTap: () => setState(() {
                  selectedAddress = address;
                }),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: GestureDetector(
                onTap: () => AddAddressSheet.showBottomSheet(context),
                child: Row(
                  children: [
                    Text(
                      "Add new address",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: AppColors.green),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.add_circle_rounded,
                      color: AppColors.green,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceSection(double totalPrice) {
    return RoundedContainer(
      color: AppColors.white,
      hasAllCornersRounded: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            priceRow("Full price", totalPrice * 1.3),
            priceRow("Discount", totalPrice * 0.3),
            priceRow("Subtotal", totalPrice.toDouble(),
                fontWeight: FontWeight.w800),
            if (pickupMethod == 0) priceRow("Delivery fee", 4),
            priceRow("Tips", tips.toDouble()),
            const Divider(
              indent: 40,
              endIndent: 40,
            ),
            priceRow("Total", (totalPrice + tips + (pickupMethod == 0 ? 4 : 0)),
                fontWeight: FontWeight.w800),
          ],
        ),
      ),
    );
  }

  Widget _addMoreSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: GestureDetector(
        onTap: () =>
            BlocProvider.of<RootPageBloc>(context).add(const ChangePage(0)),
        child: Row(children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(
              Icons.add_circle_outlined,
              color: AppColors.primary,
            ),
          ),
          Text(
            "Add more",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.primary),
          ),
        ]),
      ),
    );
  }

  Widget priceRow(String text, double price, {FontWeight? fontWeight}) {
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

  List<Widget> _cartDeviceTile(Pizza pizza, int quantity) {
    return [
      ListTile(
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Image.asset(pizza.imagePath ?? "assets/pizza1.jpg"),
        ),
        title: Text(
          pizza.name,
          style: Theme.of(context).textTheme.titleSmall,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: TextStyler.priceSection(context, pizza.price),
        trailing: _quantityEditor(pizza, quantity),
      ),
      const Divider(
        indent: 5,
      ),
    ];
  }

  Widget _quantityEditor(Pizza pizza, int quantity) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(
          color: AppColors.tertiary, // Set the border color to black
          width: 0.5, // Set the border width
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () => BlocProvider.of<CartBloc>(context)
                  .add(RemoveFromCart(pizza, 1)),
              icon: const Icon(Icons.remove)),
          Text(
            quantity.toString(),
            style: Theme.of(context).textTheme.labelLarge,
          ),
          IconButton(
              onPressed: () =>
                  BlocProvider.of<CartBloc>(context).add(AddToCart(pizza, 1)),
              icon: const Icon(Icons.add)),
        ],
      ),
    );
  }

  Widget _methodSelectorSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, right: 32, left: 32),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          color: AppColors.tertiary.withOpacity(0.2),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            _methodSelectorButton(
                "Delivery",
                pickupMethod == 0,
                () => setState(() {
                      pickupMethod = 0;
                    })),
            _methodSelectorButton(
                "PickUp",
                pickupMethod == 1,
                () => setState(() {
                      pickupMethod = 1;
                    }))
          ],
        ),
      ),
    );
  }

  Widget _methodSelectorButton(
      String text, bool isSelected, void Function() onSelect) {
    return Expanded(
      child: GestureDetector(
        onTap: onSelect,
        child: Container(
          padding: const EdgeInsets.all(4),
          height: 30,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: isSelected ? AppColors.white : null,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style: isSelected
                  ? Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: AppColors.primary)
                  : Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }
}
