import 'package:loakulukota_app/constant.dart';
import 'package:flutter/material.dart';
import 'package:loakulukota_app/pages/settings/settings.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:convert';
import 'home_screen.dart';
import 'package:loakulukota_app/pages/verification/verification_list.dart';
import 'package:loakulukota_app/pages/history/history_list.dart';
import 'package:loakulukota_app/pages/item/item_list.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Map<String, dynamic> _auth = {};
  List _pageOptions = [
    const HomeScreen(),
    const VerificationListScreen(),
    const HistoryListScreen(),
    const ItemListScreen(),
    const Settings(),
  ];
  int selectedPage = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedAuth = prefs.getString('auth') ?? "{}";
    prefs.setBool('isFirst', false);
    prefs.setBool('isLogin', true);
    setState(() {
      _auth = json.decode(encodedAuth);
      _pageOptions = _auth['role'] == 'admin' ? _pageOptions : [
        const HomeScreen(),
        const HistoryListScreen(),
        const ItemListScreen(),
        const Settings(),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pageOptions[selectedPage],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              indicatorColor: Colors.redAccent,
              labelTextStyle: MaterialStateProperty.all(const TextStyle(
                fontSize: 15,
              ))),
          child: NavigationBar(
            animationDuration: const Duration(seconds: 1),
            destinations: [
              const NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  label: 'Beranda',
                  selectedIcon: Icon(Icons.home_filled)),
              if(_auth['role'] == 'admin') ... [
                const NavigationDestination(
                  icon: Icon(Icons.verified_outlined),
                  label: 'Validasi',
                  selectedIcon: Icon(Icons.verified))
              ],
              const NavigationDestination(
                  icon: Icon(Icons.watch_later_outlined),
                  label: 'Histori',
                  selectedIcon: Icon(Icons.watch_later)),
              const NavigationDestination(
                  icon: Icon(Icons.inventory_2_outlined),
                  label: 'Gudang',
                  selectedIcon: Icon(Icons.inventory_2)),
              const NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  label: 'Settings',
                  selectedIcon: Icon(Icons.settings)),
            ],
            selectedIndex: selectedPage,
            onDestinationSelected: (int index) {
              setState(() {
                selectedPage = index;
              });
            },
            backgroundColor: Colors.redAccent.withOpacity(0.4),
          ),
        ));
  }
}
