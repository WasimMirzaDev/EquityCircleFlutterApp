import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/features/feeds/feedScreen.dart';
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Color.fromRGBO(186, 150, 255, 0.94),
                Color.fromRGBO(200, 170, 255, 0.80),
                Color.fromRGBO(180, 130, 240, 2),
              ],
              stops: [0.2, 0.5, 1.0],
              center: Alignment(0.0, 0.0),
              radius: 0.85, //
            ),
          ),
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.transparent,
            highlightElevation: 0,
            elevation: 0,
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: Container(
          height: 60,
          color: Colors.white,
          child: FractionallySizedBox(
            heightFactor: 1.32,
            widthFactor:
                0.93, // Adjust this value to control the width of the navigation bar
            child: AnimatedBottomNavigationBar.builder(
              itemCount: iconImages.length,
              tabBuilder: (int index, bool isActive) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    5.heightBox,
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
                        padding: EdgeInsets.only(
                          top: 12,
                          left: 8,
                        ), // Adjust this value for more spacing
                        child: Image.asset(
                          iconImages[index],
                          height: 18,
                          width: 18,
                          color: isActive ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    5.heightBox,
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
              activeIndex: _selectedIndex,
              gapLocation: GapLocation.none,
              notchSmoothness: NotchSmoothness.smoothEdge,
              backgroundColor: Colors.grey[100],
              onTap: ontapItem,
            ),
          ),
        ),
      ),
    );
  }
}
