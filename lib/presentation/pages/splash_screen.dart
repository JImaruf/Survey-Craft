import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:survey_craft/config/constants/text_styles.dart';
import 'package:survey_craft/presentation/pages/form_list.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const FormList(),));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.assignment, size: 80.sp, color: Colors.teal),
            SizedBox(height: 20.h),
            Text(
              'SurveyCraft',
              style: AppTextStyles.title
            ),
            SizedBox(height: 10.h),
            Text('Loading...', style: AppTextStyles.caption),
          ],
        ),
      ),
    );
  }
}
