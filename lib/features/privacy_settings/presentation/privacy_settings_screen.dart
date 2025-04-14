import 'package:equitycircle/core/constants/appFonts.dart' show AppFonts;
import 'package:equitycircle/core/constants/theme_colors.dart' show ThemeColors;
import 'package:equitycircle/core/extensions/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/appColors.dart';
import '../../../core/constants/assets.dart';
import '../../../core/widgets/custom_appbar.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  // Toggle switches
  bool isPrivate = true;
  bool isActive = true;
  bool isStorySharing = true;
  bool isLoginNotificationEnabled = true;

  // Radio button selections
  String photoOption = 'auto';
  String profileVisibility = 'public';

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
          title: "Privacy Settings",
          onLeadingPressed: () {
            Navigator.pop(context);
          },
        ),

        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Divider(color: ThemeColors.borderColor(context), thickness: 0.5.h),
            20.heightBox,
            _buildSwitchTile(
              title: 'Private Account',
              value: isPrivate,
              onChanged: (val) => setState(() => isPrivate = val),
            ),
            _buildSwitchTile(
              title: 'Active Status',
              value: isActive,
              onChanged: (val) => setState(() => isActive = val),
            ),
            _buildSwitchTile(
              title: 'Story Sharing',
              value: isStorySharing,
              onChanged: (val) => setState(() => isStorySharing = val),
            ),
            const SizedBox(height: 20),
            const Text(
              'Photo Of You',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            _buildRadioTile('Add Automatically', 'auto', photoOption, (val) {
              setState(() => photoOption = val!);
            }),
            _buildRadioTile('Add Manually', 'manual', photoOption, (val) {
              setState(() => photoOption = val!);
            }),
            _buildDescription(),
            const SizedBox(height: 20),
            const Text(
              'Your Profile',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            _buildRadioTile('Public', 'public', profileVisibility, (val) {
              setState(() => profileVisibility = val!);
            }),
            _buildRadioTile('Friend', 'friend', profileVisibility, (val) {
              setState(() => profileVisibility = val!);
            }),
            _buildRadioTile('Specific Friend', 'specific', profileVisibility, (
              val,
            ) {
              setState(() => profileVisibility = val!);
            }),
            _buildRadioTile('Only Me', 'only_me', profileVisibility, (val) {
              setState(() => profileVisibility = val!);
            }),
            _buildDescription(),
            const SizedBox(height: 20),
            const Text(
              'Login Notification',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            _buildRadioTile(
              'Enable',
              'enable',
              isLoginNotificationEnabled ? 'enable' : 'disable',
              (val) {
                setState(() => isLoginNotificationEnabled = val == 'enable');
              },
            ),
            _buildRadioTile(
              'Disable',
              'disable',
              isLoginNotificationEnabled ? 'enable' : 'disable',
              (val) {
                setState(() => isLoginNotificationEnabled = val == 'enable');
              },
            ),
            _buildDescription(),
            const SizedBox(height: 30),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.support_agent_rounded,
                color: Colors.deepPurple,
              ),
              title: const Text(
                'Support',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // Handle support tap
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          value: value,
          onChanged: onChanged,
        ),
        _buildDescription(),
      ],
    );
  }

  Widget _buildRadioTile(
    String title,
    String value,
    String groupValue,
    ValueChanged<String?> onChanged,
  ) {
    return RadioListTile<String>(
      title: Text(title),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
        'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, '
        'when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
        style: TextStyle(
          fontSize: 12.sp,
          fontFamily: AppFonts.inter,
          fontWeight: FontWeight.w400,
          color: ThemeColors.textColor(context),
        ),
      ),
    );
  }
}
