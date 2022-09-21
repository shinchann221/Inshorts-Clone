import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import '../models/news_model.dart';

class NewsService {
  String endpoint = 'https://newsapi.org/v2/top-headlines?country=in';
  final Map<String, String> _headers = {
    'X-Api-Key': '58d2bdaa0ebc4339959f67a1a9dcb5ce',
  };

  //get top headlines
  Future<List<NewsModel>> getHeadlines() async {
    Response response = await get(Uri.parse(endpoint), headers: _headers);
    if (response.statusCode == 200) {
      final List result = json.decode(response.body)['articles'];
      return result.map(((e) => NewsModel.fromJson(e))).toList();
    } else {
      throw Exception(response.statusCode);
    }
  }

  //get search query results
  Future<List<NewsModel>> getQuery(Map<String, String> query) async {
    String uri =
        '$endpoint&${query['category'] != '' ? 'category=${query['category']}' : ''}${query['q'] != '' ? 'q=${query['a']}' : ''}';
    Response response = await get(Uri.parse(uri), headers: _headers);
    if (response.statusCode == 200) {
      final List result = json.decode(response.body)['articles'];
      return result.map(((e) => NewsModel.fromJson(e))).toList();
    } else {
      throw Exception(response.statusCode);
    }
  }
}

final newsProvider = Provider<NewsService>((ref) => NewsService());
