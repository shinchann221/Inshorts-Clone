import 'package:flutter_riverpod/flutter_riverpod.dart';

class Query {
  String query = '';
  String category = '';

  set queryString(String query) {
    this.query = query;
  }

  set categoryString(String category) {
    this.category = category;
  }

  Map<String, String> get queryMap {
    return {'query': query, 'category': category};
  }
}

final queryBuilderProvider = StateProvider<Query>((ref) => Query());
