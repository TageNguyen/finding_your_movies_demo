import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListContentPlaceHolder extends StatelessWidget {
  final LeadingShape leadingShape;
  final int itemCount;
  final math.Random rd = math.Random();
  ListContentPlaceHolder({
    super.key,
    this.leadingShape = LeadingShape.square,
    this.itemCount = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: ListView.separated(
        itemCount: itemCount,
        shrinkWrap: true,
        separatorBuilder: (_, __) => const SizedBox(height: 10.0),
        itemBuilder: (context, index) {
          return _ContentPlaceholder(
            lineType: ContentLineType.values[rd.nextInt(2)],
            leadingShape: leadingShape,
          );
        },
      ),
    );
  }
}

enum ContentLineType {
  twoLines,
  threeLines,
}

enum LeadingShape {
  square,
  circle,
  none,
}

class _ContentPlaceholder extends StatelessWidget {
  final ContentLineType lineType;
  final LeadingShape leadingShape;

  const _ContentPlaceholder({
    this.leadingShape = LeadingShape.square,
    required this.lineType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leadingShape == LeadingShape.square)
            Container(
              width: 96.0,
              height: 72.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
            )
          else if (leadingShape == LeadingShape.circle)
            const CircleAvatar(radius: 40.0),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 10.0,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 8.0),
                ),
                if (lineType == ContentLineType.threeLines)
                  Container(
                    width: double.infinity,
                    height: 10.0,
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 8.0),
                  ),
                Container(
                  width: 100.0,
                  height: 10.0,
                  color: Colors.white,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
