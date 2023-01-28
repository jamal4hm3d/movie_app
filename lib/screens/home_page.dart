import 'package:flutter/material.dart';
import 'package:spot_app/widgets/featured.dart';
import 'package:spot_app/widgets/studios.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: const [FeaturedScenes(), Studios()],
      ),
    );
  }
}
