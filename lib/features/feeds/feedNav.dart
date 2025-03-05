import 'package:equitycircle/features/feeds/feedScreen.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class Feednav extends StatefulWidget {
  Feednav({super.key});

  @override
  _FeednavState createState() => _FeednavState();
}

class _FeednavState extends State<Feednav> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    FeedbackPage(),
    Center(child: Text("Bitcoin")),
    Center(child: Text("Fitness")),
    Center(child: Text("Psychology")),
  ];

  final List<IconData> iconList = [
    Icons.business,
    Icons.currency_bitcoin,
    Icons.fitness_center,
    Icons.psychology,
  ];

  void ontapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _widgetOptions.elementAt(_selectedIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.amber,
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _selectedIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        backgroundColor: Colors.white,
        activeColor: Color(0xFFb3b35c),
        inactiveColor: Colors.black,
        onTap: ontapItem,
      ),
    );
  }
}
