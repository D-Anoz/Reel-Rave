import 'dart:convert';
import 'dart:developer' as developer;

import 'package:reelrave/core/constant/api_services.dart';
import 'package:http/http.dart' as http;

import '../../model/forYou.dart';
import '../../model/popular.dart';
import '../../model/topRated.dart';

class HomeServices {
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

  Future<List<MovieResult>> getTopRated() async {
    List<MovieResult> breeds = [];
    try {
      final response = await http.get(Uri.parse('${AppServices.baseUrl}${AppServices.upComing}?api_key=${AppServices.api_key}'));
      print(response.statusCode);
      // var data = response;
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('results') && data['results'] != null) {
          // final List<dynamic> results = data['results'];
          print(data['results']);
          // breeds = (data['results'] as List<dynamic>).map((item) => ResultModel.fromJson(item)).toList();
          breeds = (data['results'] as List<dynamic>).map((item) {
            return MovieResult.fromJson(item);
          }).toList();

          // developer.log('datd: ${data.toString()}');
          developer.log('breeds:  ${breeds.toString()}');

          //  breeds = MovieResponse.fromJson(data);

          // breeds = data['results'].map<ResultModel>((json) => ResultModel.fromJson(json)).toList();
          //results; //.map<ResultModel>((json) => ResultModel.fromJson(json)).toList();
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
      print(response.statusCode);
      // var data = response;
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('results') && data['results'] != null) {
          // final List<dynamic> results = data['results'];
          print(data['results']);
          // breeds = (data['results'] as List<dynamic>).map((item) => ResultModel.fromJson(item)).toList();
          popularList = (data['results'] as List<dynamic>).map((item) {
            return PopularResult.fromJson(item);
          }).toList();

          // developer.log('datd: ${data.toString()}');
          developer.log('breeds:  ${popularList.toString()}');

          //  breeds = MovieResponse.fromJson(data);

          // breeds = data['results'].map<ResultModel>((json) => ResultModel.fromJson(json)).toList();
          //results; //.map<ResultModel>((json) => ResultModel.fromJson(json)).toList();
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
}
