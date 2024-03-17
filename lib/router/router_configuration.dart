import 'package:finding_your_movies_demo/models/movie/movie.dart';
import 'package:finding_your_movies_demo/ui/home/home_screen.dart';
import 'package:finding_your_movies_demo/ui/home/login/login_screen.dart';
import 'package:finding_your_movies_demo/ui/home/movie_details/movie_details_screen.dart';
import 'package:finding_your_movies_demo/ui/home/user_profile/saved_movies/saved_movies_screen.dart';
import 'package:finding_your_movies_demo/ui/home/user_profile/user_profile_screen.dart';
import 'package:finding_your_movies_demo/ui/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouterConfiguration {
  static GoRouter router = GoRouter(
    onException: (_, GoRouterState state, GoRouter router) {
      router.go(NotFoundScreen.routeName, extra: state.uri.toString());
    },
    routes: <RouteBase>[
      GoRoute(
        path: HomeScreen.routeName,
        name: HomeScreen.routeName,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            fadeTransitionPage(const HomeScreen(), state),
        routes: <RouteBase>[
          GoRoute(
              path: MovieDetailsScreen.routeName,
              name: MovieDetailsScreen.routeName,
              pageBuilder: (BuildContext context, GoRouterState state) {
                final movie = state.extra as Movie;
                return fadeTransitionPage(MovieDetailsScreen(movie: movie), state);
              }),
          GoRoute(
            path: LoginScreen.routeName,
            name: LoginScreen.routeName,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                fadeTransitionPage(const LoginScreen(), state),
          ),
          GoRoute(
            path: UserProfileScrenn.routeName,
            name: UserProfileScrenn.routeName,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                fadeTransitionPage(const UserProfileScrenn(), state),
            routes: [
              GoRoute(
                path: SavedMoviesScreen.routeName,
                name: SavedMoviesScreen.routeName,
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    fadeTransitionPage(const SavedMoviesScreen(), state),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  static Page fadeTransitionPage(Widget child, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        );
      },
    );
  }
}

extension GoRouterExtension on GoRouter {
  String get location {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();
    return location;
  }
}
