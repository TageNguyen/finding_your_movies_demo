import 'package:finding_your_movies_demo/resource/app_image_paths.dart';
import 'package:flutter/material.dart';

class AppFadeInImage extends StatelessWidget {
  final String imageUrl;
  final String? placeholderPath;
  const AppFadeInImage({super.key, required this.imageUrl, this.placeholderPath});

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      key: key,
      placeholderFit: BoxFit.contain,
      image: NetworkImage(imageUrl),
      placeholder: AssetImage(placeholderPath ?? AppImagePaths.imagePlaceholder),
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset(placeholderPath ?? AppImagePaths.imagePlaceholder,
            fit: BoxFit.contain);
      },
      fit: BoxFit.cover,
    );
  }
}
