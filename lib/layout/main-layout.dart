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
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(0.r),
            bottomRight: Radius.circular(0.r),
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
        ],
      ),

      body: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const BouncingScrollPhysics(),
          onPageChanged: (index) {
            if (_isAdmin || index != 2) {
              setState(() {
                _currentIndex = index;
              });
            } else {
              _pageController.jumpToPage(_currentIndex);
            }
          },
          children: [
            BusinessScreen(categoryId: 1),

            FitnessScreen(categoryId: 2),
            if (_isAdmin) Container(),
            CryptoScreen(categoryId: 3),
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
            if (_isAdmin && index == 2) {
              showPostOptions(context);
            } else {
              setState(() {
                _currentIndex = index;
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
            }
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
            if (_isAdmin)
              BottomNavigationBarItem(
                icon: GestureDetector(
                  onTap: () {
                    showPostOptions(context);
                  },
                  child:
                      _currentIndex == 2
                          ? SvgPicture.asset(Assets.addPostPurpleIcon)
                          : SvgPicture.asset(Assets.addPostIcon),
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
