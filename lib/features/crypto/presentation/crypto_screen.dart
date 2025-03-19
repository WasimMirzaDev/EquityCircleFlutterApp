import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/assets.dart' show Assets;
import 'package:equitycircle/core/constants/constants.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/features/bussiness/presentation/widgets/custom_search_field.dart';
import 'package:flutter/material.dart';

import '../../bussiness/presentation/widgets/custom_carousal_widget.dart';

class CryptoScreen extends StatefulWidget {
  final int categoryId;
  const CryptoScreen({super.key, required this.categoryId});

  @override
  State<CryptoScreen> createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  final TextEditingController searchController = TextEditingController();

  final PageController _pageController = PageController();
  int currentIndex = 0;

  List<String> images = [
    Assets.cryptoImg,
    Assets.cryptoImg,
    Assets.cryptoImg,
    Assets.cryptoImg,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: PAGE_MARGIN_HOR),
          child: Column(
            children: [
              20.heightBox,
              customeSearchWidget("   Search for users", searchController),
              12.heightBox,

              customCarousalSlider(
                images,
                _pageController,
                (index) => setState(() => currentIndex = index),
                currentIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
