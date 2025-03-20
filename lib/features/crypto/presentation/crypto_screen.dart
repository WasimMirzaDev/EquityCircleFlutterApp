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

  final List<Map<String, dynamic>> posts = [
    {
      "imageUrl":
          "https://images.unsplash.com/photo-1423479185712-25d4a4fe1006?q=80&w=2676&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "author": "Jerome Bell",
      "time": "Today at 10:12 pm",
      "content": """💡 Why Crypto?
✅ Secure & Transparent – Blockchain ensures safety.
✅ Global Access – Anyone, anywhere, anytime.
✅ High Growth Potential – A new era of investment.
💡 Why Crypto?
✅ Secure & Transparent – Blockchain ensures safety.
✅ Global Access – Anyone, anywhere, anytime.
✅ High Growth Potential – A new era of investment.""",
      "category": "Crypto",
      "lightColor": AppColors.lightYellow,
      "darkColor": AppColors.yellow,
      "attachments": [
        {
          "url":
              'https://s3-alpha-sig.figma.com/img/c90d/ef86/6e328d7596c29f7bdbd0b6cbd1210476?Expires=1743379200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=bEvpEffeo2cEhcgoIsncf-T0JzpiGf6E5tXW19OaAWa-2EOE2WwHXENrhdl0fUQIi4Jzs5pX~IH4PLF~DEhvhjxPSNpHi65-eHl7xDwFEDC1dvl8-bqvOtHIkGcTQtxf~egyqn3tHG2bL7o-mBem8fv3~MDPiGMseWmsC0uAsmO3tRuMFQr-UHE6-0Aera5Jhw0F6~eZJ1lqods7RiFo1XTzzsoRdR3n2NWFLp8zK0A9JGaImzmFaHa3awQTWuoYkhKAq2vXIu37EmI0EOKdzvw7BsV~VwLBe6oMGLSUfnay6xUa9ZKSBN6DRGU-fZARewItFPenN~Qa6LO1XXoW2w__',
        },
      ],
      "is_liked": false,
      "likes": [
        2,
        2,
        2,
        3,
        3,
        3,
        3,
        1,
        1,
        2,
        2,
        2,
        3,
        3,
        3,
        3,
        1,
        1,
        2,
        2,
        2,
        3,
        3,
        3,
        3,
        1,
        1,
      ],
      "comments": [1, 2, 2, 2, 3, 3, 3, 3, 1, 1],
    },
    {
      "imageUrl":
          "https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0?q=80&w=2676&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "author": "Jerome Bell",
      "time": "Yesterday at 5:00 pm",
      "content":
          "📢 The Future is Decentralized! 🚀 Are you ready to explore the world of cryptocurrencies and blockchain technology? Here’s why crypto is shaping the future of finance: 🌐 Borderless Transactions: Transfer funds globally in minutes. 🔒 Enhanced Security: Built on blockchain for transparency and security. 📈 Investment Opportunities: Bitcoin, Ethereum, and other cryptocurrencies offer potential for significant returns.",
      "category": "Bitcoin",
      "lightColor": AppColors.lightYellow,
      "darkColor": AppColors.yellow,
      "attachments": [
        {
          "url":
              'https://s3-alpha-sig.figma.com/img/0180/5574/cd588cdde95bef612104efd1787af9b1?Expires=1743379200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=ZrG53qCyLgJ~2FYQl~VIzxY3oCDIbl1P1ScRkwaBLcL17Xu~zab0wYjrtfonyFC4fn9iBJtzVzTMWj~VaNFO3Pcb~NgK0X-3oyiC7nNZIYYmXuWj~OSRXHvP~9rv~hj1~GBal~o9HmbOpZvX6B~wva1UGvXHoZ6yjbDUnweiFDYcmNPPjwb7SR35fpXhyRf9dYEVgdl27zgsxcmWrmthVogDSMZm10t54bQIu3-r9wLS4DhmL0Qxm5uobp41R1sLJpfzB~2fv5lJ8402JiE4ik8RN0Buw2wzi7wL~2M5-GCkajqi2MS~FdSX4M6uWmby2kMFRwbRBcpyqO1jUgOmOA__',
        },
      ],
      "is_liked": true,
      "likes": [2, 2, 2, 3, 3, 3, 3, 1, 1, 2, 2, 2, 3, 3, 3, 3, 1, 1],
      "comments": [3, 3, 3, 3, 1, 1],
    },
    {
      "imageUrl":
          "https://s3-alpha-sig.figma.com/img/1e83/2cd5/96aa7da2d61d5f318e6fe73ff4f2a059?Expires=1743379200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=fmdXWnKKyVldZU5yxAjRnEUwsDX9KQQ0keRjgIt1Cte7y4jTy3PIbmXrhRIISTQp4H1LPEiAhbfd7AUBYl~7WYyCiMKrmu5mBx8s8D9cO2qh-Ir-x7lrWyNErjjUDePE2ZaJSwNKkyjMTehaJL4WidlG5XkHCGBi2xZ48MMGOVtXnltrza69wyJHIW97T0wJIGLxt3gZUd6RFwLrJkX~SB9XGes5jXSlsrINgiosrY4WR7d5viDFzEK43yw9xPM6KUYy~KOC2~422P608xgx0kz93pftIxDroC5MCKIZM9OJlNwc-xfmBzC-~lR6ROtGXsL6E-twrX6mRD3-wt5x9g__",
      "author": "Alice Smith",
      "time": "2 days ago",
      "content": """✅ Secure & Transparent – Blockchain ensures safety.
✅ Global Access – Anyone, anywhere, anytime.
✅ High Growth Potential – A new era of investment.""",
      "category": "Ethereum",
      "lightColor": AppColors.lightYellow,
      "darkColor": AppColors.yellow,
      "attachments": [
        {
          "url":
              'https://s3-alpha-sig.figma.com/img/c24b/2f96/e057677456e6e61451c2bd89eb5c1344?Expires=1743379200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=cALejfpWicTBBnLnn8P-y0Yym09mGcDCEURScwvyk6CeCpt7Ezarv1iiJa5ryRmeGI-9fpJ09fvnZp6P5s1-eMVZFRDNZJpuxqLmUbfT-2JUqjK8mTrwxmkQtaRp0xIFwPY7WVAZ0zmAYohljsb4GtBWXnjOzX7lQnOm~qFk7CSU5PIdChUxfuatZ9ww9Kh0wRtjaM~4hk5vqeEyAryvVus9Q4k9zC8phM4a4e-pGGsC3dYQns0MbsyQP~898JX7RtvqQvCEKp4RS-cTmiaN0arEIWasNhOZlXhSUGpBJ6N3GeTY9R3J3PpXvPG8x7fuIn6~0lxtIO~LGeT9jUMrDA__',
        },
      ],
      "is_liked": true,
      "likes": [2, 2, 2, 3, 3, 3, 3, 1, 1, 2, 2, 2, 3, 3, 3, 3, 1, 1],
      "comments": [3, 3, 3, 1, 1],
    },
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
                  ...posts.map((post) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: customPostContainer(
                        post["imageUrl"],
                        post["author"],
                        post["time"],
                        post["content"],
                        () {},
                        () {},
                        post["category"],
                        post["lightColor"],
                        post["darkColor"],
                        post["attachments"],
                        context,
                        post["likes"],
                        post["is_liked"],
                        post["comments"],
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
