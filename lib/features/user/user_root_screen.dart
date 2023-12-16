import 'package:pizza_app/common/theme/colors.dart';
import 'package:pizza_app/features/admin/management/ingredient/ingredient_form.dart';
import 'package:pizza_app/features/admin/management/pizza/pizza_form.dart';
import 'package:pizza_app/features/user/home/user_home.dart';
import 'package:pizza_app/profile/profile_sheet.dart';
import 'package:flutter/material.dart';

class UserRootScreen extends StatefulWidget {
  const UserRootScreen({super.key});

  @override
  State<UserRootScreen> createState() => _UserRootScreenState();
}

class _UserRootScreenState extends State<UserRootScreen> {
  final List<Widget> _pages = [const UserHomePage()];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = 0; // Update the selected tab index
    });
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
            label: "Search",
            icon: Icon(
              Icons.search,
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
        onTap: _onItemTapped,
      ),
    );
  }
}
