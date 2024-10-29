import 'package:flutter/widgets.dart';
import 'package:reelrave/main.dart';

import '../../presentation/screen/top rated/top_rated.dart';

class AppRoutes {
  static const String initialScreen = '/';
  // static const String search = '/searchScreen';
  // static const String tv = '/tvScreen';
  // static const String saved = '/savedScreen';
  // static const String profile = '/profileSScreen';
  static const String topRated = '/topRatedScreen';
  // static const String popular = '/';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      initialScreen: (context) => const SplashScreen(),
      // search: (context) => const SearchPage(),
      // tv: (context) => const TVScreen(),
      // saved: (context) => const SavedListPage(),
      // profile: (context) => const ProfilePage(),
      topRated: (context) => const TopRated(),
      // popular:(context) => const MovieHomePage();
    };
  }
}
