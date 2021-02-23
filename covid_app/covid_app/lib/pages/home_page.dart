import 'package:covid_app/pages/upload_page.dart';
import 'package:covid_app/pages/weights_page.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:covid_app/pages/display_page.dart';
import 'package:covid_app/pages/help_page.dart';

class HomePage extends StatefulWidget {
  final int changedTab;
  HomePage({Key key, this.changedTab}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int changedTab;
  // controls the pages
  PageController _pageController = PageController();
  // the different screens of the navigation bar
  List<Widget> _screens = [DisplayPage(), UploadPage(), WeightsPage(), HelpPage()];
  // the index of the currently selected screen on the navigation bar
  int _selectedIndex = 0;

  // change page functionality
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void changeTab(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 350), curve: Curves.easeIn);
    });
  }

  // when an item on the bottom nav bar is tapped
  void _onItemTapped(int selectedIndex) {
    _pageController.animateToPage(selectedIndex,
        duration: Duration(milliseconds: 350), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    if (changedTab != null) {
      changeTab(changedTab);
    }
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        //currentIndex: _selectedIndex,
        onTap:
            _onItemTapped, //(int index) => setState(() => _selectedIndex = index),
        items: [

          // HOME PAGE
          BottomNavigationBarItem(
            icon: Icon(
              MdiIcons.accountGroupOutline,
              color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
            ),
            title: Text(
              "Ego Network",
              style: TextStyle(
                color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
              ),
            ),
          ),

          // UPLOAD DATA PAGE
          BottomNavigationBarItem(
            icon: Icon(
              MdiIcons.upload,
              color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
            ),
            title: Text(
              "Upload Data",
              style: TextStyle(
                color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
              ),
            ),
          ),

          // Weights page
          BottomNavigationBarItem(
            icon: Icon(
              MdiIcons.accountCog,
              color: _selectedIndex == 2 ? Colors.blue : Colors.grey,
            ),
            title: Text(
              "Weights",
              style: TextStyle(
                color: _selectedIndex == 2 ? Colors.blue : Colors.grey,
              ),
            ),
          ),

          //CDC Guidelines

          //HelpPage
          BottomNavigationBarItem(
            icon: Icon(
              MdiIcons.accountQuestion,
              color: _selectedIndex == 3 ? Colors.blue : Colors.grey,
            ),
            title: Text(
              "Help",
              style: TextStyle(
                color: _selectedIndex == 3 ? Colors.blue : Colors.grey,
              ),
            )
          )

        ],
      ),
    );
  }
}
