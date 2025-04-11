import 'package:flutter/material.dart';
import 'package:money_view/main.dart';
import 'package:money_view/pages/add_new.dart';
import 'package:money_view/pages/charts.dart';
import 'package:money_view/pages/history.dart';

import 'package:money_view/pages/home_page.dart';
import 'package:money_view/pages/profile.dart';

class TabPage extends StatefulWidget {
  TabPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabPageState();
  }
}

class _TabPageState extends State<TabPage> {
  int currentPageIndex = 2;

  void _selectedTab(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  var activePageIcon = Icons.home;

  Widget activePage = HomePage();

  @override
  Widget build(BuildContext context) {
    if (currentPageIndex == 0) {
      activePage = Charts();
    } else if (currentPageIndex == 1) {
      activePage = AddNew();
    } else if (currentPageIndex == 3) {
      activePage = History();
    } else if (currentPageIndex == 4) {
      activePage = Profile();
    } else {
      activePage = HomePage();
    }
    return Scaffold(
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex,
        unselectedItemColor: kColorScheme.onPrimaryFixedVariant,
        fixedColor: kColorScheme.onPrimary,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph_rounded),
            label: 'Charts',
            backgroundColor: kColorScheme.onSecondaryContainer,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
            backgroundColor: kColorScheme.onSecondaryContainer,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: kColorScheme.onSecondaryContainer,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
            backgroundColor: kColorScheme.onSecondaryContainer,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.face),
            label: 'Profile',
            backgroundColor: kColorScheme.onSecondaryContainer,
          ),
        ],
        onTap: _selectedTab,
      ),
    );
  }
}
