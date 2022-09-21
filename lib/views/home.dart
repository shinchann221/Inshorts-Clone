import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/data_provider.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  //Todo: Style Search bar
  //Todo: style Bottom Sheet
  //Todo: Implement route to new page or figure out to reload page
  //Todo: Add InShorts style single news on single page sort of thing

  @override
  Widget build(BuildContext context, ref) {
    int? tag = -1;
    List<String> options = [
      'Business',
      'Entertainment',
      'General',
      'Health',
      'Science',
      'Sports',
      'Technology'
    ];

    final data = ref.watch(newsHeadlineProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  elevation: 4,
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  context: context,
                  builder: (_) {
                    return StatefulBuilder(
                      builder: (ctx, stateSetter) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const TextField(),
                              const SizedBox(height: 50),
                              const Text('Select a category if you want'),
                              ChipsChoice.single(
                                wrapped: true,
                                value: tag,
                                onChanged: (int val) =>
                                    stateSetter(() => tag = val),
                                choiceItems: C2Choice.listFrom<int, String>(
                                  source: options,
                                  value: (i, v) => i,
                                  label: (i, v) => v,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text('Search'),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  });
            },
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 30,
          )
        ],
        title: const Text(
          'News App',
        ),
      ),
      body: data.when(
        data: (data) {
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                return Card(
                  color: Colors.white,
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Image.network((data[i].urlToImage)),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          data[i].title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/webview',
                            arguments: data[i].url);
                      },
                    ),
                  ),
                );
              });
        },
        error: (error, s) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.red,
          );
        },
        loading: () {
          return const Center(
            child: SizedBox(
              height: 75,
              width: 75,
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                color: Colors.yellow,
                strokeWidth: 10,
              ),
            ),
          );
        },
      ),
    );
  }
}
