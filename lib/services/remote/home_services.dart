import 'dart:convert';

import 'package:reelrave/core/constant/api_services.dart';
import 'package:http/http.dart' as http;

// import '../../model/forYou.dart';
import '../../model/popular.dart';
import '../../model/topRated.dart';

class HomeServices {
  Future<List<MovieResult>> getTopRated() async {
    List<MovieResult> breeds = [];
    try {
      final response = await http.get(Uri.parse('${AppServices.baseUrl}${AppServices.upComing}?api_key=${AppServices.api_key}'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('results') && data['results'] != null) {
          breeds = (data['results'] as List<dynamic>).map((item) {
            return MovieResult.fromJson(item);
          }).toList();

          return breeds;
        } else {
          throw Exception('Exception occured: ${response.body}');
        }
      } else {
        throw Exception('Exception occured: ${response.body}');
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

//for popular movies
  Future<List<PopularResult>> getPopular() async {
    List<PopularResult> popularList = [];
    try {
      final response = await http.get(Uri.parse('${AppServices.baseUrl}${AppServices.popular}?api_key=${AppServices.api_key}'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('results') && data['results'] != null) {
          popularList = (data['results'] as List<dynamic>).map((item) {
            return PopularResult.fromJson(item);
          }).toList();

          return popularList;
        } else {
          throw Exception('Exception occured: ${response.body}');
        }
      } else {
        throw Exception('Exception occured: ${response.body}');
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  /// below code doesnot work.

  // Future<UpcomingModel> getUpcoming() async {
  //   // List<UpcomingModel> upComings = [];
  //   try {
  //     final response = await http.get(Uri.parse('${AppServices.baseUrl}${AppServices.upComing}?api_key=${AppServices.api_key}'));
  //     print('Status code: ${response.statusCode}');
  //     developer.log(response.body);

  //     print('URL: ${AppServices.baseUrl}${AppServices.upComing}?api_key=${AppServices.api_key}');
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> result = json.decode(response.body);
  //       UpcomingModel upComings = UpcomingModel.fromJson(result);
  //       print(upComings);
  //       // print('Response: ${response.body}');
  //       return upComings;
  //     } else {
  //       throw Exception('Exception occurred: ${response.body}');
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     rethrow;
  //   }
  // }
}
