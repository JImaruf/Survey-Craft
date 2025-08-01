import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:survey_craft/config/constants/app_colors.dart';
 // Your color constants

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
        onPressed: () => Navigator.of(context).pop(),
      )
          : null,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      actions: actions,
      backgroundColor: AppColors.primary,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16.r),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}
