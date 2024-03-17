import 'package:finding_your_movies_demo/l10n/translations.dart';
import 'package:finding_your_movies_demo/models/movie/movie.dart';
import 'package:finding_your_movies_demo/resource/app_colors.dart';
import 'package:finding_your_movies_demo/resource/extensions/double_ex.dart';
import 'package:finding_your_movies_demo/resource/widgets/app_fade_in_image.dart';
import 'package:finding_your_movies_demo/ui/home/movie_details/movie_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;
  const MovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: InkWell(
        onTap: () {
          context.pushNamed(MovieDetailsScreen.routeName, extra: movie);
        },
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: AppFadeInImage(imageUrl: movie.posterurl),
              ),
              const SizedBox(height: 10.0),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        movie.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.star_outlined,
                            color: Colors.amber,
                            size: 16.0,
                          ),
                          const SizedBox(width: 6.0),
                          Text(
                            movie.imdbRating.toStringFormat(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.0,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(width: 6.0),
                          Expanded(
                            child: Text(
                              '${movie.duration.inMinutes} ${Translations.of(context).minutes}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 10.0,
                                height: 1.2,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
