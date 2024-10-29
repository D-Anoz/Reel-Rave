import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reelrave/core/constant/colors.dart';
import 'package:reelrave/core/constant/images.dart';
import 'package:reelrave/core/route/route.dart';
import 'package:reelrave/presentation/bloc/home/home_bloc.dart';

import 'presentation/screen/mainpage.dart';

void main() {
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (_) => HomeBloc())
      ],
      child: MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: AppColors.bgColor),
        initialRoute: '/',
        routes: AppRoutes.getRoutes(),
      )));
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.splashScreenImg,
          height: 140,
        ),
        const Text(
          'Reels Rave',
          style: TextStyle(fontSize: 23, color: Colors.white, decoration: TextDecoration.none),
        )
      ],
    );
  }
}
