import 'package:finding_your_movies_demo/providers/app_provider.dart';
import 'package:finding_your_movies_demo/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: context.read<AppProvider>().loadingStream,
      builder: (context, snapshot) {
        bool isLoading = snapshot.data ?? false;
        if (isLoading) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 46.0, vertical: 24.0),
              decoration: BoxDecoration(
                color: AppColors.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Transform.scale(
                scale: 0.8,
                child: const CircularProgressIndicator(
                  strokeWidth: 2.0,
                  color: AppColors.white,
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
