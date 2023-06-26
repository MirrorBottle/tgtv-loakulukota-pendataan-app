import 'package:loakulukota_app/constant.dart';
import 'package:flutter/material.dart';
import 'package:loakulukota_app/pages/settings/settings.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:convert';
import 'home_screen.dart';
import 'package:loakulukota_app/pages/villager/villager_list.dart';




class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Map<String, dynamic> _auth = {};
  List _pageOptions = [
    const HomeScreen(),
    const VillagerListScreen(),
    const VillagerListScreen(),
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
        const VillagerListScreen(),
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
              indicatorColor: constPrimaryColor,
              labelTextStyle: MaterialStateProperty.all(const TextStyle(
                fontSize: 15,
                color: Colors.black
              ))),
          child: NavigationBar(
            animationDuration: const Duration(seconds: 1),
            destinations: [
              const NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  label: 'Beranda',
                  selectedIcon: Icon(Icons.home_filled, color: Colors.white)),
              if(_auth['role'] == 'admin') ... [
                const NavigationDestination(
                  icon: Icon(Icons.verified_outlined),
                  label: 'Validasi',
                  selectedIcon: Icon(Icons.verified, color: Colors.white))
              ],
              const NavigationDestination(
                  icon: Icon(Icons.people_alt_outlined),
                  label: 'Penduduk',
                  selectedIcon: Icon(Icons.people, color: Colors.white)),
              const NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  label: 'Pengaturan',
                  selectedIcon: Icon(Icons.settings, color: Colors.white)),
            ],
            selectedIndex: selectedPage,
            onDestinationSelected: (int index) {
              setState(() {
                selectedPage = index;
              });
            },
            backgroundColor: constSecondaryColor,
          ),
        ));
  }
}
