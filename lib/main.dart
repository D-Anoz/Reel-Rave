import 'package:flutter/material.dart';
import 'package:reelrave/core/constant/colors.dart';
import 'package:reelrave/core/constant/images.dart';

import 'presentation/screen/home.dart';

void main() => runApp(MaterialApp(
      home: const SplashScreen(),
      theme: ThemeData(scaffoldBackgroundColor: AppColors.bgColor),
    ));

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
