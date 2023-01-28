import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spot_app/services/data_provider.dart';
import 'package:flutter/services.dart';

class ScenePage extends ConsumerWidget {
  const ScenePage({super.key, required this.slug});

  final String slug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? newLink;
    final data = ref.watch(movieDataProvider(slug));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video"),
      ),
      body: data.when(
        data: (data) {
          newLink = data.data?.movieByPk?.megaLink;
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(data.data?.movieByPk?.background ?? ""),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    data.data?.movieByPk?.name ?? "",
                    style: const TextStyle(fontSize: 35),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    data.data?.movieByPk?.description ?? "",
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) {
          return Text(
            error.toString(),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () async {
          Clipboard.setData(ClipboardData(text: newLink)).then((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Copied to your clipboard !'),
              ),
            );
          });
        },
        child: const Icon(Icons.copy),
      ),
    );
  }
}
