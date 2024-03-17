import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomePagePlaceHolder extends StatelessWidget {
  const HomePagePlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: size.height * 0.5,
            decoration: const BoxDecoration(color: Colors.white),
          ),
          const Expanded(child: GridViewPlaceHolder()),
        ],
      ),
    );
  }
}

class GridViewPlaceHolder extends StatelessWidget {
  final int itemCount;
  const GridViewPlaceHolder({super.key, this.itemCount = 12});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      childAspectRatio: 3 / 5,
      children: List.generate(
        itemCount,
        (index) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
