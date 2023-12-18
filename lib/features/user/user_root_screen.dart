import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/common/theme/colors.dart';
import 'package:pizza_app/features/user/cart/cart_screen.dart';
import 'package:pizza_app/features/user/home/user_home.dart';
import 'package:pizza_app/features/user/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/features/user/order_history/bloc/history_bloc.dart';
import 'package:pizza_app/features/user/page_bloc/root_page_bloc.dart';

import 'order_history/order_history_screen.dart';

class UserRootScreen extends StatefulWidget {
  const UserRootScreen({super.key});

  @override
  State<UserRootScreen> createState() => _UserRootScreenState();
}

class _UserRootScreenState extends State<UserRootScreen> {
  final List<Widget> _pages = [
    const UserHomePage(),
    const CartScreen(),
    const OrderHistoryScreen(),
    const ProfileScreen()
  ];

  void _onItemTapped(int index) {
    if (index >= _pages.length) {
      BlocProvider.of<RootPageBloc>(context).add(const ChangePage(0));
    } else {
      if (index == 2) {
        BlocProvider.of<HistoryBloc>(context).add(const FetchHistory());
      }
      BlocProvider.of<RootPageBloc>(context).add(ChangePage(index));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootPageBloc, RootPageState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          automaticallyImplyLeading: false,
          title: const Row(
            children: [
              Text("Slice2You"),
            ],
          ),
        ),
        body: _pages[state.index],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(
                Icons.home,
              ),
            ),
            BottomNavigationBarItem(
              label: "Cart",
              icon: Icon(
                Icons.shopping_cart,
              ),
            ),
            BottomNavigationBarItem(
              label: "Orders",
              icon: Icon(
                Icons.receipt,
              ),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(
                Icons.person,
              ),
            )
          ],
          unselectedLabelStyle: Theme.of(context).textTheme.labelMedium,
          selectedLabelStyle: Theme.of(context).textTheme.labelMedium,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.secondary,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          currentIndex: state.index,
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
