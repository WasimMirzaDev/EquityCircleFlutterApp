import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/assets.dart' show Assets;
import 'package:equitycircle/core/constants/constants.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/features/bussiness/presentation/widgets/custom_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bussiness/presentation/widgets/custom_carousal_widget.dart';
import '../../bussiness/presentation/widgets/custom_post_container.dart';

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
    Assets.carousalImg,
    Assets.fitnessImg,
    Assets.mindsetImg,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: PAGE_MARGIN_HOR),
        child: Column(
          children: [
            20.heightBox,

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  customeSearchWidget("   Search for users", searchController),
                  12.heightBox,
                  customCarousalSlider(
                    images,
                    _pageController,
                    (index) => setState(() => currentIndex = index),
                    currentIndex,
                  ),
                  20.heightBox,
                  ...List.generate(5, (index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: customPostContainer(
                        "https://images.unsplash.com/photo-1423479185712-25d4a4fe1006?q=80&w=2676&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                        "Hira Kiran",
                        "Today at 12:24 pm",

                        'Crypto (cryptocurrency) is a digital or virtual currency secured by cryptography, enabling decentralized and secure transactions without intermediaries like banks. Examples include Bitcoin and Ethereum.',
                        () {},
                        () {},
                        "Crypto",

                        AppColors.lightYellow,
                        AppColors.yellow,
                        [
                          {
                            "url":
                                'https://media.istockphoto.com/id/919509810/photo/new-virtual-money-concept-gold-bitcoins-is-digital-crypto-currency-use-blockchain-technology.jpg?s=1024x1024&w=is&k=20&c=XG_z0UOP3RHw6eJ1LOzuwOWwvdkv_qv3mr4APBDIbVk=',
                          },
                        ],
                        context,
                        [],
                        true,
                        [],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
