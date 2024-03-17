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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: size.height * 0.6,
              decoration: const BoxDecoration(color: Colors.white),
            ),
            _TitleSectionPlaceHolder(width: size.width * 0.2),
            const _HorizontalListItemPlaceHolder(height: 160.0, itemCount: 5),
            _TitleSectionPlaceHolder(width: size.width * 0.3),
            const _HorizontalListItemPlaceHolder(height: 160.0, itemCount: 5),
          ],
        ),
      ),
    );
  }
}

class _TitleSectionPlaceHolder extends StatelessWidget {
  final double width;
  const _TitleSectionPlaceHolder({required this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 8,
            width: width,
            color: Colors.white,
          ),
          Container(
            height: 8,
            width: width * 0.75,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class _HorizontalListItemPlaceHolder extends StatelessWidget {
  final double height;
  final int itemCount;
  const _HorizontalListItemPlaceHolder({this.height = 160.0, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(width: 10.0),
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.33,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
