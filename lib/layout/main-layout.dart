import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/constants/constants.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/providers/auth_provider.dart';
import 'package:equitycircle/features/bussiness/presentation/bussiness_screen.dart';
import 'package:equitycircle/features/bussiness/presentation/widgets/drawer_widget.dart';
import 'package:equitycircle/features/crypto/presentation/crypto_screen.dart';
import 'package:equitycircle/features/feeds/helpers/picture_helpers.dart';
import 'package:equitycircle/features/mindset/presentation/mindset_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../features/fitness/presentation/fitness_screen.dart';

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
        width: 320.w,
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
        ),
        child: DrawerContent(),
      ),

      appBar: AppBar(
        backgroundColor: AppColors.offWhite,
        leading: Padding(
          padding: EdgeInsets.only(left: PAGE_MARGIN_HOR),
          child: IconButton(
            icon: SvgPicture.asset(
              Assets.drawerIcon,
              // fit: BoxFit.cover,
            ),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icon/Equity_Circle_icon.png",
              height: 30.h,
              width: 30.w,
            ),
            8.widthBox,
            Text(
              'Equity Circle',
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: AppFonts.inter,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
          ],
        ),
        actions: [
          16.widthBox,
          SvgPicture.asset(
            width: 24.w,
            height: 24.h,
            Assets.notificationIcon,
            // fit: BoxFit.cover,
          ),
          14.widthBox,
          Container(
            width: 30.r,
            height: 30.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.purpleColor, width: 1.w),
            ),
            child: CircleAvatar(
              backgroundColor: AppColors.lightGreyColor,
              radius: 20.r,
              backgroundImage: NetworkImage(
                getProfileImageUrl(authProvider.userData),
              ),
            ),
          ),
          16.widthBox,
          // PopupMenuButton(
          //   child:
          //   authProvider.userData == null
          //       ? Padding(
          //         padding: const EdgeInsets.only(right: 10.0),
          //         child: Icon(Icons.more_vert),
          //       )
          //       :
          //   CircleAvatar(
          //     backgroundColor: AppColors.lightGreyColor,
          //     radius: 20.r,
          //     backgroundImage: NetworkImage(
          //       getProfileImageUrl(authProvider.userData),
          //     ),
          //   ),
          //   itemBuilder:
          //       (context) => [
          //         if (!authProvider.isAuthenticated)
          //           const PopupMenuItem<String>(
          //             value: 'Sign In',
          //             child: Text('Sign In'),
          //           ),
          //         if (authProvider.isAuthenticated)
          //           PopupMenuItem<String>(
          //             onTap: () {
          //               Provider.of<AuthProvider>(
          //                 context,
          //                 listen: false,
          //               ).logout();
          //               context.go('/login');
          //             },
          //             value: 'Sign Out',
          //             child: const Text('Sign Out'),
          //           ),
          //         const PopupMenuItem<String>(
          //           value: 'Edit Profile',
          //           child: Text('Edit Profile'),
          //         ),
          //         const PopupMenuItem<String>(
          //           value: 'Account Settings',
          //           child: Text('Account Settings'),
          //         ),
          //       ],
          //   onSelected: (value) {
          //     switch (value) {
          //       case 'Sign In':
          //         GoRouter.of(context).push('/login');
          //         break;
          //       case 'Sign Up':
          //         GoRouter.of(context).push('/register');
          //         break;
          //       case 'Edit Profile':
          //         break;
          //       case 'Account Settings':
          //         break;
          //     }
          //   },
          // ),
        ],
      ),

      body: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const BouncingScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: [
            BussinessScreen(categoryId: 1),
            FitnessScreen(categoryId: 2),
            BussinessScreen(categoryId: 3),
            CryptoScreen(categoryId: 4),
            MindsetScreen(categoryId: 5),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: const Border(
            top: BorderSide(color: AppColors.lightGreyColor, width: 0.5),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.purpleColor,
          unselectedItemColor: AppColors.greyColor,
          selectedLabelStyle: TextStyle(
            fontSize: 12.sp,
            fontFamily: AppFonts.inter,
            fontWeight: FontWeight.w400,
          ),
          selectedIconTheme: IconThemeData(color: AppColors.purpleColor),
          unselectedIconTheme: IconThemeData(color: AppColors.greyColor),
          unselectedLabelStyle: TextStyle(
            height: 0,
            fontSize: 12.sp,
            fontFamily: AppFonts.inter,
            fontWeight: FontWeight.w400,
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
          items: [
            BottomNavigationBarItem(
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    width: 24.w,
                    height: 24.h,
                    Assets.bussinesIcon,
                    color:
                        _currentIndex == 0
                            ? AppColors.purpleColor
                            : AppColors.greyColor,
                  ),

                  3.heightBox,
                ],
              ),
              label: 'Business',
            ),

            BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(
                    width: 24.w,
                    height: 24.h,
                    Assets.fitnessIcon,
                    color:
                        _currentIndex == 1
                            ? AppColors.purpleColor
                            : AppColors.greyColor,
                  ),
                  3.heightBox,
                ],
              ),
              label: 'Fitness',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [SvgPicture.asset(Assets.addPostIcon), 3.heightBox],
              ),
              label: 'Add post',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(
                    width: 24.w,
                    height: 24.h,
                    Assets.cryptoIcon,
                    color:
                        _currentIndex == 3
                            ? AppColors.purpleColor
                            : AppColors.greyColor,
                  ),
                  3.heightBox,
                ],
              ),
              label: 'Crypto',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  3.heightBox,
                  SvgPicture.asset(
                    Assets.mindsetIcon,
                    color:
                        _currentIndex == 4
                            ? AppColors.purpleColor
                            : AppColors.greyColor,
                    width: 24.w,
                    height: 24.h,
                  ),
                ],
              ),
              label: 'Mindset',
            ),
          ],
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
