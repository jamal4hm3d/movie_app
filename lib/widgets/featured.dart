import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spot_app/services/data_provider.dart';
import 'package:spot_app/widgets/scene_image.dart';

class FeaturedScenes extends ConsumerWidget {
  const FeaturedScenes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(featuredProvider);
    return Container(
      child: data.when(
        data: (data) {
          return Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            width: double.infinity,
            height: 250,
            child: CarouselSlider.builder(
              itemCount: data.data?.scene?.length,
              itemBuilder: (context, index, realIndex) {
                return SceneImage(
                    url: data.data?.scene?[index].background,
                    slug:data.data?.scene?[index].slug);
              },
              options: CarouselOptions(
                  autoPlay: false,
                  aspectRatio: 16 / 9,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  enableInfiniteScroll: false),
            ),
          );
        },
        error: (error, stackTrace) {
          return const Text("There was an error");
        },
        loading: () {
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

