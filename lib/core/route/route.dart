import 'package:flutter/widgets.dart';
import 'package:reelrave/main.dart';
import 'package:reelrave/presentation/screen/popular/popular.dart';

import '../../presentation/screen/top rated/top_rated.dart';

class AppRoutes {
  static const String initialScreen = '/';

  static const String topRated = '/topRatedScreen';
  static const String popular = '/popular';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      initialScreen: (context) => const SplashScreen(),
      topRated: (context) => const TopRated(),
      popular: (context) => const PopularScreen()
    };
  }
}
