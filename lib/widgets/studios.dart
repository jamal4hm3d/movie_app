import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spot_app/services/data_provider.dart';
import 'package:spot_app/widgets/scene_image.dart';

class Studios extends ConsumerWidget {
  const Studios({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(studoDataProvider);
    return data.when(
      data: (data) {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.data?.studio?.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.data?.studio?[index].name ?? ""),
                Container(
                  margin: const EdgeInsets.all(5),
                  child: SizedBox(
                    height: 250,
                    child: ListView.builder(
                      itemCount: data.data?.studio?[index].scenes?.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index2) {
                        return Container(
                          padding: const EdgeInsets.all(5),
                          child: SceneImage(
                              url: data
                                  .data?.studio?[index].scenes?[index2].background,
                              slug: data.data?.studio?[index].scenes?[index2].slug),
                        );
                      },
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
      error: (error, stackTrace) {
        return const Text("Something is wrong");
      },
      loading: () {
        return const CircularProgressIndicator();
      },
    );
  }
}
