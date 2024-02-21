import 'package:flutter/material.dart';
import 'package:flutter_project/screens/account.dart';
import 'package:flutter_project/screens/cart_screen.dart';
import 'package:flutter_project/screens/faverite_screen.dart';
import 'package:flutter_project/screens/home.dart';
import 'package:flutter_project/screens/shop.dart';
import 'package:flutter_project/theme.dart';

class NavigationBarBottom extends StatefulWidget {
  static const String idScreen = "bottomnav";
  const NavigationBarBottom({Key key}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBarBottom> {
  int currentIndex = 0;
  final screens = [HomeScreen(), ShopScreen(), const ProfileDetails()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(children: [screens[currentIndex]]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store_outlined),
            label: "Store",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Accounts",
          ),
        ],
        backgroundColor: background,
        unselectedItemColor: Colors.black,
        selectedItemColor: PrimaryColor,
      ),
    );
  }
}
