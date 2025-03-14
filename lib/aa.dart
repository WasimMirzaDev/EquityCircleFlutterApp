import 'package:equitycircle/features/feeds/feedScreen.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class Feednav extends StatefulWidget {
  const Feednav({super.key});

  @override
  _FeednavState createState() => _FeednavState();
}

class _FeednavState extends State<Feednav> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    FeedbackPage(),
    Center(child: Text("Bitcoin")),
    Center(child: Text("Fitness")),
    Center(child: Text("Psychology")),
  ];

  final List<String> iconImages = [
    'assets/images/logo_icons/crypto.png',
    'assets/images/logo_icons/crypto.png',
    'assets/images/logo_icons/fitness.png',
    'assets/images/logo_icons/mindset.png',
  ];

  final List<String> labels = ["Business", "Crypto", "Fitness", "Mindset"];

  void ontapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: _widgetOptions.elementAt(_selectedIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.purple,
        elevation: 4,
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          height: 60,
          color: Colors.white,
          child: AnimatedBottomNavigationBar.builder(
            itemCount: iconImages.length,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.verySmoothEdge,
            activeIndex: _selectedIndex,
            backgroundColor: Colors.grey[100],
            onTap: ontapItem,
            tabBuilder: (int index, bool isActive) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 5),
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return isActive
                          ? RadialGradient(
                            center: Alignment.center,
                            radius: 1.0,
                            colors: [
                              Color.fromRGBO(137, 106, 255, 0.94),
                              Color.fromRGBO(154, 106, 252, 1),
                              Color.fromRGBO(128, 36, 226, 1),
                            ],
                            tileMode: TileMode.mirror,
                          ).createShader(bounds)
                          : LinearGradient(
                            colors: [Colors.black, Colors.black],
                          ).createShader(bounds);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 12, left: 8),
                      child: Image.asset(
                        iconImages[index],
                        height: 18,
                        width: 18,
                        color: isActive ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: Text(
                      labels[index],
                      style: TextStyle(
                        fontSize: 7,
                        fontWeight: FontWeight.w400,
                        color: isActive ? Color(0xFF896AFF) : Colors.black,
                      ),
                    ),
                  ),
                  if (isActive)
                    Container(
                      margin: EdgeInsets.only(top: 3),
                      height: 3,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(137, 106, 255, 0.94),
                            Color.fromRGBO(154, 106, 252, 1),
                            Color.fromRGBO(128, 36, 226, 1),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
