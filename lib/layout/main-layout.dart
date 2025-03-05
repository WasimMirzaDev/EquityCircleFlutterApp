import 'package:equitycircle/core/providers/auth_provider.dart';
import 'package:equitycircle/features/feeds/feeds_page.dart';
import 'package:equitycircle/features/feeds/helpers/picture_helpers.dart';
import 'package:equitycircle/features/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  final GoRouterState state;
  const MainLayout({super.key, required this.child, required this.state});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final PageController _pageController = PageController();
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // ✅ Add a GlobalKey
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = _calculateSelectedIndex(widget.state.uri.toString());

    // ✅ Delay execution until first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pageController.hasClients) {
        _pageController.jumpToPage(_currentIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      key: _scaffoldKey, // ✅ Assign the GlobalKey here
      /*drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(child: Text("Equity Circle Menu")),
            ListTile(leading: Icon(Icons.settings), title: Text("Settings")),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text("Feedback"),
              onTap: () {
                context.go('/feedback');
              },
            ),
            GestureDetector(
              onTap: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
                context.go('/login');
              },
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
              ),
            ),
          ],
        ),
      ),*/
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: Colors.blueGrey, width: 0.01),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/logo_icons/Equity_Circle_full.png',
                        height: 40,
                        width: 40,
                      ),

                      Text(
                        "Equity Circle",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home", style: GoogleFonts.poppins()),
              onTap: () => context.go('/home'),
            ),
            ListTile(
              leading: Icon(Icons.school),
              title: Text("Education", style: GoogleFonts.poppins()),
              onTap: () => context.go('/education'),
            ),
            ListTile(
              leading: Icon(Icons.work_outline),
              title: Text("Joblish", style: GoogleFonts.poppins()),
              onTap: () => context.go('/joblish'),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text("Calendar", style: GoogleFonts.poppins()),
              onTap: () => context.go('/calendar'),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text("Notifications", style: GoogleFonts.poppins()),
              onTap: () => context.go('/notifications'),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text("Settings", style: GoogleFonts.poppins()),
              onTap: () {
                context.go('/settings');
              },
            ),

            ListTile(
              leading: Icon(Icons.feedback),
              title: Text("Feedback"),
              onTap: () {
                context.go('/feedback');
              },
            ),
            GestureDetector(
              onTap: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
                context.go('/login');
              },
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
              ),
            ),
          ],
        ),
      ),

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState
                ?.openDrawer(); // ✅ Open drawer using GlobalKey
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icon/Equity_Circle_icon.png",
              height: 30,
              width: 30,
            ),
            const SizedBox(width: 10),
            Text(
              'Equity Circle',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton(
            child:
                authProvider.userData == null
                    ? Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Icon(Icons.more_vert),
                    )
                    : Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          getProfileImageUrl(authProvider.userData),
                        ),
                      ),
                    ),
            itemBuilder:
                (context) => [
                  if (!authProvider.isAuthenticated)
                    const PopupMenuItem<String>(
                      value: 'Sign In',
                      child: Text('Sign In'),
                    ),
                  if (authProvider.isAuthenticated)
                    PopupMenuItem<String>(
                      onTap: () {
                        Provider.of<AuthProvider>(
                          context,
                          listen: false,
                        ).logout();
                        context.go('/login');
                      },
                      value: 'Sign Out',
                      child: const Text('Sign Out'),
                    ),
                  const PopupMenuItem<String>(
                    value: 'Edit Profile',
                    child: Text('Edit Profile'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Account Settings',
                    child: Text('Account Settings'),
                  ),
                ],
            onSelected: (value) {
              switch (value) {
                case 'Sign In':
                  GoRouter.of(context).push('/login');
                  break;
                case 'Sign Up':
                  GoRouter.of(context).push('/register');
                  break;
                case 'Edit Profile':
                  break;
                case 'Account Settings':
                  break;
              }
            },
          ),
        ],
      ),

      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(), // ✅ Smooth swipe effect
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          FeedsPage(categoryId: 1),
          FeedsPage(categoryId: 2),
          FeedsPage(categoryId: 3),
          FeedsPage(categoryId: 4),
        ],
      ),

      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // Ensure background color matches your theme
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: BottomNavigationBar(
            type:
                BottomNavigationBarType
                    .fixed, // ✅ Ensures labels are always shown
            backgroundColor: Colors.white, // Match the container color
            fixedColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Theme.of(context).textTheme.bodyMedium!.color,
            unselectedLabelStyle: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.business_center_outlined),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.currency_bitcoin_sharp),
                label: 'Crypto',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.fitness_center_sharp),
                label: 'Fitness',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.lightbulb_outlined),
                label: 'Mindset',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// **Helper function to determine selected index from URL**
int _calculateSelectedIndex(String location) {
  if (location.startsWith('/')) return 0;

  if (location.startsWith('/crypto')) return 1;

  if (location.startsWith('/fitness')) return 2;

  if (location.startsWith('/mindset')) return 3;
  return 0;
}
