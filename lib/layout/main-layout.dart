import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/appFonts.dart';
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/constants/constants.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/providers/auth_provider.dart';
import 'package:equitycircle/features/bussiness/presentation/widgets/drawer_widget.dart';
import 'package:equitycircle/features/crypto/presentation/crypto_screen.dart';
import 'package:equitycircle/features/feeds/helpers/picture_helpers.dart';
import 'package:equitycircle/features/mindset/presentation/mindset_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../core/constants/theme_colors.dart';
import '../features/add_post/presentation/addpost_bottomsheet.dart';
import '../features/bussiness/presentation/bussiness_screen.dart';
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
  bool _isAdmin = false;
  @override
  void initState() {
    super.initState();
    _currentIndex = _calculateSelectedIndex(widget.state.uri.toString());

    // ✅ Delay execution until first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      bool isAdmin = await authProvider.checkAdmin(context);
      setState(() {
        _isAdmin = isAdmin;
      });

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

      drawer: Drawer(
        width: double.infinity,
        backgroundColor: ThemeColors.background(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(0.r),
            bottomRight: Radius.circular(0.r),
          ),
        ),
        child: DrawerContent(),
      ),

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeColors.background(context),
        leading: Padding(
          padding: EdgeInsets.only(left: PAGE_MARGIN_HOR),
          child: IconButton(
            icon: SvgPicture.asset(
              Assets.drawerIcon,
              color: ThemeColors.iconColor(context),
              // fit: BoxFit.cover,
            ),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
        title: SvgPicture.asset(
          Assets.logo,
          height: 16.h,

          color: ThemeColors.logoColor(context),
        ),
        actions: [
          16.widthBox,
          SvgPicture.asset(
            width: 24.w,
            height: 24.h,
            Assets.notificationIcon,
            color: ThemeColors.iconColor(context), // fit: BoxFit.cover,
          ),
          14.widthBox,
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ProfileSettingsScreen(),
              //   ),
              // );
            },
            child: Container(
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
          ),
          16.widthBox,
        ],
      ),

      body: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const BouncingScrollPhysics(),
          onPageChanged: (index) {
            _pageController.jumpToPage(_currentIndex);
          },

          children: [
            BusinessScreen(categoryId: 1),

            CryptoScreen(categoryId: 3),

            FitnessScreen(categoryId: 2),

            MindsetScreen(categoryId: 5),
          ],
        ),
      ),
      floatingActionButton:
          _isAdmin
              ? Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: GestureDetector(
                  onTap: () {
                    showPostOptions(context);
                  },
                  child: Container(
                    width: 55.w,
                    height: 55.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? null
                              : AppColors.purpleColor,
                      gradient:
                          Theme.of(context).brightness == Brightness.dark
                              ? LinearGradient(
                                begin: Alignment.topLeft,

                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFFFFFFF), // white
                                  Color(0xFF686868), // gray
                                ],
                              )
                              : null,
                      border: Border.all(
                        color: Color(0x33000000), // black with 20% opacity
                        width: 2.w,
                      ),
                    ),
                    child: Icon(
                      Icons.add,
                      color: ThemeColors.fabAddIcon(context),
                    ),
                  ),
                ),
              )
              : SizedBox.shrink(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: kBottomNavigationBarHeight + 32.h,
            decoration: BoxDecoration(
              color:
                  Theme.of(context).brightness == Brightness.light
                      ? AppColors.white
                      : null, // remove color if dark mode
              gradient:
                  Theme.of(context).brightness == Brightness.dark
                      ? const LinearGradient(
                        colors: [Color(0xFF1A1A1A), Color(0xFF0E0E0E)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                      : null,
            ),
          ),
          BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            selectedItemColor: AppColors.purpleColor,
            unselectedItemColor: ThemeColors.bottomNavText(context),
            selectedLabelStyle: TextStyle(
              fontSize: 10.sp,
              fontFamily: AppFonts.inter,
              fontWeight: FontWeight.w400,
            ),
            selectedIconTheme: IconThemeData(color: AppColors.purpleColor),
            unselectedIconTheme: IconThemeData(
              color: ThemeColors.bottomNavText(context),
            ),
            unselectedLabelStyle: TextStyle(
              height: 0,
              fontSize: 10.sp,
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
                  children: [
                    SvgPicture.asset(
                      Assets.bussinesIcon,
                      width: 22.w,
                      height: 22.h,
                      color:
                          _currentIndex == 0
                              ? AppColors.purpleColor
                              : ThemeColors.bottomNavText(context),
                    ),
                    5.heightBox,
                  ],
                ),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(right: 30.w),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        Assets.cryptoIcon,
                        width: 22.w,
                        height: 22.h,
                        color:
                            _currentIndex == 1
                                ? AppColors.purpleColor
                                : ThemeColors.bottomNavText(context),
                      ),
                      5.heightBox,
                    ],
                  ),
                ),
                label: 'Crypto          ',
              ),

              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        Assets.fitnessIcon,
                        width: 22.w,
                        height: 22.h,
                        color:
                            _currentIndex == 2
                                ? AppColors.purpleColor
                                : ThemeColors.bottomNavText(context),
                      ),
                      5.heightBox,
                    ],
                  ),
                ),
                label: '            Fitness',
              ),
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    SvgPicture.asset(
                      Assets.mindsetIcon,
                      width: 22.w,
                      height: 22.h,
                      color:
                          _currentIndex == 3
                              ? AppColors.purpleColor
                              : ThemeColors.bottomNavText(context),
                    ),
                    5.heightBox,
                  ],
                ),
                label: 'Mindset',
              ),
            ],
          ),
        ],
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



                // if (_isAdmin)
                //   BottomNavigationBarItem(
                //     icon: GestureDetector(
                //       onTap: () {
                //         showPostOptions(context);
                //       },
                //       child:
                //           _currentIndex == 2
                //               ? SvgPicture.asset(Assets.addPostPurpleIcon)
                //               : SvgPicture.asset(Assets.addPostIcon),
                //     ),
                //     label: 'Add post',
                //   ),