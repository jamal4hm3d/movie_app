import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spot_app/services/services.dart';
import 'package:spot_app/types/featured_type.dart';
import 'package:spot_app/types/movie_data.dart';
import 'package:spot_app/types/studio_type.dart';

final featuredProvider = FutureProvider<Featured>(
  (ref) async {
    return ref.watch(apiProvider).fetchFeatured();
  },
);

final movieDataProvider = FutureProvider.family<MovieType, String>(
  (ref, slug) async {
    return ref.watch(apiProvider).fetchScene(slug);
  },
);

final studoDataProvider = FutureProvider<StudioType>(
  (ref) {
    return ref.watch(apiProvider).getStudioData();
  },
);
