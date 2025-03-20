import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/assets.dart' show Assets;
import 'package:equitycircle/core/constants/constants.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/features/bussiness/presentation/widgets/custom_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bussiness/presentation/widgets/custom_carousal_widget.dart';
import '../../bussiness/presentation/widgets/custom_post_container.dart';

class MindsetScreen extends StatefulWidget {
  final int categoryId;
  const MindsetScreen({super.key, required this.categoryId});

  @override
  State<MindsetScreen> createState() => _MindsetScreenState();
}

class _MindsetScreenState extends State<MindsetScreen> {
  final TextEditingController searchController = TextEditingController();

  final PageController _pageController = PageController();
  int currentIndex = 0;

  List<String> images = [
    Assets.mindsetImg,
    Assets.cryptoImg,
    Assets.fitnessImg,
    Assets.carousalImg,
  ];
  final List<Map<String, dynamic>> posts = [
    {
      "imageUrl":
          "https://images.unsplash.com/photo-1423479185712-25d4a4fe1006?q=80&w=2676&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "author": "Jerome Bell",
      "time": "Today at 10:12 pm",
      "content":
          """Mindset Matters: The Key to Personal & Professional Growth" Your mindset influences how you handle challenges and pursue success. A growth mindset opens doors to endless possibilities, while a fixed mindset limits your potential. 🔑 Tips to Develop a Growth Mindset: Learn Continuously: View mistakes as learning opportunities. Stay Resilient: Setbacks are part of growth; don’t give up.""",
      "category": "Technology",
      "lightColor": AppColors.lightPink,
      "darkColor": AppColors.darkPink,
      "attachments": [
        {
          "url":
              'https://s3-alpha-sig.figma.com/img/cb06/d367/1576797c542add03f300a2df16b0460b?Expires=1743379200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=OiBrFtRit-MAEa4gfN5QN5UbogF3~3NZZ1xAz1HOdKuSx1dOA5Jle33459r80dHMuspXXbR-Hwu48VZOVjYA3T2KSsWLEeQ~w9hE31ovgCMNKAzkN~jMSom2Jk4U6zMrJN1VkUwz3wktGL-7P3dZRHqcwWvmMAoHKXQJDJOGUuoaDNz5fWc6gAKFRQuSKjXNmJOx7hnR9s3ZUOS8AQoYGS4-4457VVxFcp1WlOL9fvNfNxkGiGBacJwbN07RUQFwMnhIFj4gS6DiYuLEorO01nA60R27qSNMlzAUISSyYemGZEQlLL4-ttafEsKqw14-79R48gNVwn-mDWD3UhiPOg__',
        },
      ],
      "is_liked": false,
      "likes": [2, 2, 2, 3, 3, 1, 1, 2, 2, 2, 3, 3, 3, 3, 1, 1],
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
      "lightColor": AppColors.lightPink,
      "darkColor": AppColors.darkPink,
      "attachments": [
        {
          "url":
              'https://s3-alpha-sig.figma.com/img/9048/6aac/f7142f44f8fadc0260a35b13c0781419?Expires=1743379200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=K-4a5QKqwrw3ZF7bnSbjWlaxduy8RdO5oJkT8S1riVV4c6kAv6~yvjfH0eVIxb8aj4p9oaODjmxn2JaTtYVJTOSsliwNBBc9QfOijIH1HxuTPEiwRkYXNq~qc3t2Nq2UBgGx4lSIILcUjqu~TEsnbvl3VQjw3BXmHV-cSXhQy1J7FZJCkLGXDOVrtGf43jP1BMzLX877bKeI41yO2b~LRflc1solMqSpdpDErIdpqkJakv-NXVqWW9Ov1LEl3XDAC-pipZphFuH0BSeO4tFWefPldxSyw0eCpNQei95GAPPQeYy1K8qGPIPanTzgieYwjnBLdUG3w2EemM1sbiddmg__',
        },
      ],
      "is_liked": true,
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
      "comments": [
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
        3,
        3,
        3,
        3,
        1,
        1,
      ],
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
      "lightColor": AppColors.lightPink,
      "darkColor": AppColors.darkPink,
      "attachments": [
        {
          "url":
              'https://s3-alpha-sig.figma.com/img/8b08/b730/fc61666e2c6e3d72ccb2b43b1cbd2772?Expires=1743379200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=TMoWZQYdAHp7hl3TPjpvmvyRKfOCvsYocLsf19ewpkpFkLxKeSI7j96UHMGJJdrOqFtmxO9k5zBnxmEjp9dP~1-mWIRmhoLCtmK7s-j89MxCS2QiegsysILRJqxtqiRZcXo5mBIdzd2Y0ogZnU4~VAabI32muT10wIDfDcouytGauQf9LUhV7Q23~8XbLvCX42QclIOdmGtLmyF9Eo-UR-SlBJea4MCwEDL3JzYMkInpxR-i9FQhY-Nf0NQUxJ8~LDMNFpGr9-OkqdXaghK1CbMPYsoXbQKRoYyk28YogrsEh-u25dlrPZrj6cCL4qn-FeGj3rBfb~lqRo3eFe9Xdg__',
        },
        {
          "url":
              'https://s3-alpha-sig.figma.com/img/8b08/b730/fc61666e2c6e3d72ccb2b43b1cbd2772?Expires=1743379200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=TMoWZQYdAHp7hl3TPjpvmvyRKfOCvsYocLsf19ewpkpFkLxKeSI7j96UHMGJJdrOqFtmxO9k5zBnxmEjp9dP~1-mWIRmhoLCtmK7s-j89MxCS2QiegsysILRJqxtqiRZcXo5mBIdzd2Y0ogZnU4~VAabI32muT10wIDfDcouytGauQf9LUhV7Q23~8XbLvCX42QclIOdmGtLmyF9Eo-UR-SlBJea4MCwEDL3JzYMkInpxR-i9FQhY-Nf0NQUxJ8~LDMNFpGr9-OkqdXaghK1CbMPYsoXbQKRoYyk28YogrsEh-u25dlrPZrj6cCL4qn-FeGj3rBfb~lqRo3eFe9Xdg__',
        },
        {
          "url":
              'https://s3-alpha-sig.figma.com/img/8b08/b730/fc61666e2c6e3d72ccb2b43b1cbd2772?Expires=1743379200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=TMoWZQYdAHp7hl3TPjpvmvyRKfOCvsYocLsf19ewpkpFkLxKeSI7j96UHMGJJdrOqFtmxO9k5zBnxmEjp9dP~1-mWIRmhoLCtmK7s-j89MxCS2QiegsysILRJqxtqiRZcXo5mBIdzd2Y0ogZnU4~VAabI32muT10wIDfDcouytGauQf9LUhV7Q23~8XbLvCX42QclIOdmGtLmyF9Eo-UR-SlBJea4MCwEDL3JzYMkInpxR-i9FQhY-Nf0NQUxJ8~LDMNFpGr9-OkqdXaghK1CbMPYsoXbQKRoYyk28YogrsEh-u25dlrPZrj6cCL4qn-FeGj3rBfb~lqRo3eFe9Xdg__',
        },
        {
          "url":
              'https://s3-alpha-sig.figma.com/img/8b08/b730/fc61666e2c6e3d72ccb2b43b1cbd2772?Expires=1743379200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=TMoWZQYdAHp7hl3TPjpvmvyRKfOCvsYocLsf19ewpkpFkLxKeSI7j96UHMGJJdrOqFtmxO9k5zBnxmEjp9dP~1-mWIRmhoLCtmK7s-j89MxCS2QiegsysILRJqxtqiRZcXo5mBIdzd2Y0ogZnU4~VAabI32muT10wIDfDcouytGauQf9LUhV7Q23~8XbLvCX42QclIOdmGtLmyF9Eo-UR-SlBJea4MCwEDL3JzYMkInpxR-i9FQhY-Nf0NQUxJ8~LDMNFpGr9-OkqdXaghK1CbMPYsoXbQKRoYyk28YogrsEh-u25dlrPZrj6cCL4qn-FeGj3rBfb~lqRo3eFe9Xdg__',
        },
        {
          "url":
              'https://s3-alpha-sig.figma.com/img/8b08/b730/fc61666e2c6e3d72ccb2b43b1cbd2772?Expires=1743379200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=TMoWZQYdAHp7hl3TPjpvmvyRKfOCvsYocLsf19ewpkpFkLxKeSI7j96UHMGJJdrOqFtmxO9k5zBnxmEjp9dP~1-mWIRmhoLCtmK7s-j89MxCS2QiegsysILRJqxtqiRZcXo5mBIdzd2Y0ogZnU4~VAabI32muT10wIDfDcouytGauQf9LUhV7Q23~8XbLvCX42QclIOdmGtLmyF9Eo-UR-SlBJea4MCwEDL3JzYMkInpxR-i9FQhY-Nf0NQUxJ8~LDMNFpGr9-OkqdXaghK1CbMPYsoXbQKRoYyk28YogrsEh-u25dlrPZrj6cCL4qn-FeGj3rBfb~lqRo3eFe9Xdg__',
        },
      ],
      "is_liked": true,
      "likes": [2, 2, 2, 3, 3, 3, 3, 1, 1, 2, 2, 2, 3, 3, 3, 3, 1, 1],
      "comments": [3, 3, 3, 1, 1],
    },
  ];

  List<List<Map<String, String>>> mediaLists = [
    [
      {
        "url":
            'https://media.istockphoto.com/id/614012698/photo/i-am-a-strong-woman.jpg?s=1024x1024&w=is&k=20&c=Dahswq7Z71XJqKx2SaNbYA3oByKhk4eot6vuHSSXNZQ=',
      },
      {"url": 'https://example.com/image2.jpg'},
    ],
    [
      {
        "url":
            'https://media.istockphoto.com/id/614012698/photo/i-am-a-strong-woman.jpg?s=1024x1024&w=is&k=20&c=Dahswq7Z71XJqKx2SaNbYA3oByKhk4eot6vuHSSXNZQ=',
      },
      {"url": 'https://example.com/image4.jpg'},
    ],
    [
      {"url": 'https://example.com/image5.jpg'},
      {"url": 'https://example.com/image6.jpg'},
    ],
    [
      {"url": 'https://example.com/image7.jpg'},
      {"url": 'https://example.com/image8.jpg'},
    ],
    [
      {"url": 'https://example.com/image9.jpg'},
      {"url": 'https://example.com/image10.jpg'},
    ],
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
