import 'package:finding_your_movies_demo/resource/app_image_paths.dart';
import 'package:flutter/material.dart';

class AppFadeInImage extends StatelessWidget {
  final String imageUrl;
  const AppFadeInImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      placeholderFit: BoxFit.contain,
      image: NetworkImage(imageUrl),
      placeholder: const AssetImage(AppImagePaths.imagePlaceholder),
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset(AppImagePaths.imagePlaceholder, fit: BoxFit.contain);
      },
      fit: BoxFit.cover,
    );
  }
}
