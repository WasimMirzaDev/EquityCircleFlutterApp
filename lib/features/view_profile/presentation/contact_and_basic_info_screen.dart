import 'package:equitycircle/core/constants/appColors.dart';
import 'package:equitycircle/core/constants/appFonts.dart' show AppFonts;
import 'package:equitycircle/core/constants/assets.dart';
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:equitycircle/core/widgets/custom_appbar.dart' show CustomAppBar;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/theme_colors.dart';
import '../../../core/widgets/custom_textfield.dart';

class ContactAndBasicInfoScreen extends StatefulWidget {
  const ContactAndBasicInfoScreen({super.key});

  @override
  _ContactAndBasicInfoScreenState createState() =>
      _ContactAndBasicInfoScreenState();
}

class _ContactAndBasicInfoScreenState extends State<ContactAndBasicInfoScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController maritalStatusController = TextEditingController();
  final TextEditingController websiteUrlController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController socialLinkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration:
          isDarkMode
              ? BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.postFormBg),
                  fit: BoxFit.fill,
                ),
              )
              : BoxDecoration(color: AppColors.white),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          title: "Contact and basic info",
          onLeadingPressed: () {
            Navigator.pop(context);
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                color: ThemeColors.borderColor(context),
                thickness: 0.5.h,
              ),
              20.heightBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("EMAIL:", context),
                    8.heightBox,
                    CustomTextField(
                      controller: emailController,
                      hint: "admin@gmail.com",
                      fillColor: ThemeColors.search(context),
                    ),
                    16.heightBox,
                    _buildLabel("PHONE:", context),
                    8.heightBox,
                    CustomTextField(
                      controller: phoneController,
                      hint: "0303 7528227",
                      fillColor: ThemeColors.search(context),
                    ),
                    16.heightBox,
                    _buildLabel("ADDRESS:", context),
                    8.heightBox,
                    CustomTextField(
                      controller: addressController,
                      hint: "Rasool Masjid Road, Faisalabad, Pakistan",
                      fillColor: ThemeColors.search(context),
                    ),
                    16.heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: _buildInputField(
                            "CITY:",
                            cityController,
                            "Faisalabad",
                            context,
                          ),
                        ),
                        12.widthBox,
                        Expanded(
                          child: _buildInputField(
                            "STATE:",
                            stateController,
                            "State",
                            context,
                          ),
                        ),
                      ],
                    ),
                    16.heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: _buildInputField(
                            "COUNTRY:",
                            countryController,
                            "Country",
                            context,
                          ),
                        ),
                        12.widthBox,
                        Expanded(
                          child: _buildInputField(
                            "DATE OF BIRTH:",
                            dobController,
                            "1999-10-06",
                            context,
                          ),
                        ),
                      ],
                    ),
                    16.heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: _buildInputField(
                            "GENDER:",
                            genderController,
                            "Male",
                            context,
                          ),
                        ),
                        12.widthBox,
                        Expanded(
                          child: _buildInputField(
                            "MARITAL STATUS:",
                            maritalStatusController,
                            "Single",
                            context,
                          ),
                        ),
                      ],
                    ),
                    16.heightBox,
                    _buildLabel("WEBSITE URL:", context),
                    8.heightBox,
                    CustomTextField(
                      controller: websiteUrlController,
                      hint: "www.website.com",
                      fillColor: ThemeColors.search(context),
                    ),
                    20.heightBox,
                    _buildLabel("Websites and Social Links", context),
                    16.heightBox,
                    _buildLabel("Website:", context),
                    8.heightBox,
                    CustomTextField(
                      controller: websiteController,
                      hint: "www.bootstrap.com",
                      fillColor: ThemeColors.search(context),
                    ),
                    16.heightBox,
                    _buildLabel("Social Link:", context),
                    8.heightBox,
                    CustomTextField(
                      controller: socialLinkController,
                      hint: "www.instagram.com/profile",
                      fillColor: ThemeColors.search(context),
                    ),
                    16.heightBox,
                  ],
                ),
              ),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12.sp,
        fontFamily: AppFonts.inter,
        fontWeight: FontWeight.w500,
        color: ThemeColors.textColor(context),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller,
    String hint,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label, context),
        8.heightBox,
        CustomTextField(
          controller: controller,
          hint: hint,
          fillColor: ThemeColors.search(context),
        ),
      ],
    );
  }
}
