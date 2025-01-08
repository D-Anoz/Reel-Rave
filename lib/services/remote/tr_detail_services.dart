import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reelrave/core/constant/api_services.dart';

import '../../model/tr_detail_model.dart';

class TopRatedDetailServices {
  // Future<TopRatedDetailModel?> fetchTopRatedDetail() async {
  //   try {
  //     final response = await http.get(Uri.parse('${AppServices.baseUrl}${AppServices.movieDetails}939243?api_key=${AppServices.api_key}'));

  //     if (response.statusCode == 200) {

  //       final TopRatedDetailModel topRatedDetail = topRatedDetailModelFromJson(response.body);
  //       print(topRatedDetail);
  //       return topRatedDetail;
  //     } else {
  //       print("Failed to load data: ${response.statusCode}");
  //       return null;
  //     }
  //   } catch (error) {
  //     print("Error fetching data: $error");
  //     return null;
  //   }
  // }

  Future<TopRatedDetailModel> fetchTRD(int id) async {
    // List<TopRatedDetailModel> topRatedDetails = [];
    try {
      // final response = await http.get(Uri.parse('${AppServices.baseUrl}${AppServices.movieDetails}939243?api_key=${AppServices.api_key}'));
      final response = await http.get(Uri.parse('${AppServices.baseUrl}${AppServices.movieDetails}$id?api_key=${AppServices.api_key}'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        TopRatedDetailModel topRatedDetails = TopRatedDetailModel.fromJson(data);
        return topRatedDetails;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
