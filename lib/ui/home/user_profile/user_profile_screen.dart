import 'package:finding_your_movies_demo/l10n/translations.dart';
import 'package:finding_your_movies_demo/models/user/user.dart';
import 'package:finding_your_movies_demo/providers/user_provider.dart';
import 'package:finding_your_movies_demo/resource/app_colors.dart';
import 'package:finding_your_movies_demo/resource/app_image_paths.dart';
import 'package:finding_your_movies_demo/resource/helpers/message_helpers.dart';
import 'package:finding_your_movies_demo/resource/widgets/app_fade_in_image.dart';
import 'package:finding_your_movies_demo/ui/home/home_screen.dart';
import 'package:finding_your_movies_demo/ui/home/user_profile/saved_movies/saved_movies_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UserProfileScrenn extends StatelessWidget {
  static const String routeName = 'user-profile';
  const UserProfileScrenn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.of(context).profile),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
        child: StreamBuilder<User?>(
          stream: context.read<UserProvider>().currentUserStream,
          builder: (_, snapshot) {
            final userData = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildUserAvatar(context, userData?.avatarUrl),
                const SizedBox(height: 32.0),
                _buildUserInformations(context, userData),
                const SizedBox(height: 18.0),
                _buildButtons(context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildUserAvatar(BuildContext context, String? avatarUrl) {
    return Center(
      child: ClipOval(
        child: AppFadeInImage(
          imageUrl: avatarUrl ?? '',
          placeholderPath: AppImagePaths.profilePlaceholder,
          height: 120.0,
          width: 120.0,
        ),
      ),
    );
  }

  Widget _buildUserInformations(BuildContext context, User? userData) {
    Widget buildInformation(IconData icon, String title, String value) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.grey),
          const SizedBox(width: 4.0),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey),
          ),
          const SizedBox(width: 4.0),
          Expanded(
            child: Text(
              value,
              style:
                  Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: AppColors.black.withOpacity(0.8),
      ),
      child: Column(
        children: [
          buildInformation(
            Icons.email,
            Translations.of(context).email,
            userData?.email ?? '',
          ),
          const SizedBox(height: 12.0),
          buildInformation(
            Icons.phone,
            Translations.of(context).phoneNumber,
            userData?.phoneNumber ?? '',
          ),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    Widget button({
      void Function()? onTap,
      bool borderTop = false,
      bool borderBottom = false,
      required IconData icon,
      required String title,
    }) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.vertical(
          top: borderTop ? const Radius.circular(8.0) : Radius.zero,
          bottom: borderBottom ? const Radius.circular(8.0) : Radius.zero,
        ),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.grey),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.grey),
                ),
              ),
              const SizedBox(width: 4.0),
              const Icon(Icons.keyboard_arrow_right),
            ],
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: AppColors.black.withOpacity(0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          button(
            icon: Icons.bookmark_border_rounded,
            title: Translations.of(context).savedMovies,
            borderTop: true,
            onTap: () {
              context.goNamed(SavedMoviesScreen.routeName);
            },
          ),
          button(
            icon: Icons.power_settings_new,
            title: Translations.of(context).logout,
            borderBottom: true,
            onTap: () => logOut(context),
          ),
        ],
      ),
    );
  }

  void logOut(BuildContext context) {
    MessageHelper.showConfirmDialog(
      context,
      message: Translations.of(context).areYouSureYouWantToLogOut,
      actionText: Translations.of(context).logOut,
    ).then((accept) {
      if (accept) {
        context.goNamed(HomeScreen.routeName);
        context.read<UserProvider>().logOut();
      }
    });
  }
}
