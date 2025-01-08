import 'dart:convert';

import 'package:reelrave/core/constant/api_services.dart';
import 'package:reelrave/model/tv_model.dart';

import 'package:http/http.dart' as http;

class TvServices {
  Future<List<TvModel>> getTVlist() async {
    List<TvModel> tv = [];

    try {
      final response = await http.get(Uri.parse('${AppServices.baseUrl}${AppServices.tvAiringToday}?${AppServices.api_key_query}'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('results')) {
          // print(data['results']);
          tv = (data['results'] as List<dynamic>).map((item) {
            return TvModel.fromJson(item);
          }).toList();

          return tv;
        } else {
          throw Exception('Exception aayo: ${response.body}');
        }
      } else {
        throw Exception('Exception aayo: ${response.body}');
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
