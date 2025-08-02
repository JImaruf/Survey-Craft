import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:survey_craft/logic/bloc/form_list_page/form_list_bloc.dart';
import 'package:survey_craft/logic/bloc/form_page/form_page_bloc.dart';
import 'package:survey_craft/presentation/pages/splash_screen.dart';

import 'core/utils/hive_constants.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await OpenBoxes().openBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider(create: (context) => FormListBloc(),),
        BlocProvider(create: (context) => FormBloc(),),
      ],
      child: ScreenUtilInit(
        designSize: Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) =>
            MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'SurveyCraft',
              home: child,
            ),
        child: SplashScreen(),
      ),
    );
  }
}


