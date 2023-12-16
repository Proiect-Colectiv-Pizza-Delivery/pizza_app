import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/common/theme/colors.dart';
import 'package:pizza_app/features/user/cart/cart_screen.dart';
import 'package:pizza_app/features/user/home/user_home.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/features/user/order_history/bloc/history_bloc.dart';

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
    const OrderHistoryScreen()
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      if (index >= _pages.length) {
        _selectedIndex = 0;
      } else {
        if (index == 2) {
          BlocProvider.of<HistoryBloc>(context).add(const FetchHistory());
        }
        _selectedIndex = index;
      }
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Row(
          children: [
            Text("Slice2You"),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
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
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}