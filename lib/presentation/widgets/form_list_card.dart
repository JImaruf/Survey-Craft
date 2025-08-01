import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:survey_craft/config/constants/app_colors.dart';
import 'package:survey_craft/config/constants/text_styles.dart';

class FormCard extends StatelessWidget {
  final String title;
  final Icon icon;
  final VoidCallback onTap;

  const FormCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SizedBox(
          // height: 160,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 70.h,
                width: 70.h, // use height to keep it perfectly circular
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                ),
                child: Center(child: icon),
              ),
              Text(
                textAlign: TextAlign.center,
                title,
                style: AppTextStyles.body
              )
            ],
          ),
        ),
      ),
    );
  }
}