import 'package:flutter/widgets.dart';
import 'package:reelrave/main.dart';
import 'package:reelrave/presentation/screen/popular/popular.dart';

import '../../presentation/screen/top rated/top_rated.dart';
import '../../presentation/screen/top rated/tr_details.dart';

class AppRoutes {
  static const String initialScreen = '/';

  static const String topRated = '/topRatedScreen';
  static const String popular = '/popular';
  static const String topRatedDetails = '/trDetails';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      initialScreen: (context) => const SplashScreen(),
      topRated: (context) => const TopRated(),
      popular: (context) => const PopularScreen(),
      topRatedDetails: (context) => const TRDetails(),
    };
  }
}
