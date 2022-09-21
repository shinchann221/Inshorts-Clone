import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/services/news_service.dart';

import '../models/news_model.dart';
import '../services/query.dart';

final newsHeadlineProvider = FutureProvider<List<NewsModel>>((ref) async {
  return ref.read(newsProvider).getHeadlines();
});

final newsQueryProvider =
    FutureProvider.family<List<NewsModel>, Map<String, String>>(
        (ref, query) async {
  return ref.read(newsProvider).getQuery(query);
});

final queryStateProvider = Provider.family<void, List<String>>((ref, list) {
  ref.read(queryBuilderProvider.notifier).state.queryString = list[0];
  ref.read(queryBuilderProvider.notifier).state.categoryString = list[1];
  return;
});

final queryProvider = Provider<Map<String, String>>(
    (ref) => ref.watch(queryBuilderProvider).queryMap);
