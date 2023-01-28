import 'package:flutter/material.dart';
import 'package:spot_app/screens/movie_page.dart';

class SceneImage extends StatelessWidget {
  const SceneImage({Key? key, required this.url, required this.slug})
      : super(key: key);

  final String? url;
  final String? slug;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image(
            image: NetworkImage(url ?? ""),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error);
            },
          )),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScenePage(slug: slug ?? ""),
          ),
        );
      },
    );
  }
}
