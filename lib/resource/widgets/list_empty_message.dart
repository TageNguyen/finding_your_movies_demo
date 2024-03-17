import 'package:finding_your_movies_demo/l10n/translations.dart';
import 'package:finding_your_movies_demo/resource/widgets/refresh_and_loadmore_widget.dart';
import 'package:flutter/material.dart';

class ListEmptyMessage extends StatelessWidget {
  final String? message;
  final Future<void> Function()? onRefresh;
  const ListEmptyMessage({super.key, this.message, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshAndLoadmoreWidget(
      onRefresh: onRefresh,
      child: ListView(
        padding: EdgeInsets.fromLTRB(
            16.0, MediaQuery.of(context).size.height * 0.45, 16.0, 24.0),
        children: [
          const Icon(
            Icons.folder_copy,
            color: Colors.grey,
          ),
          const SizedBox(height: 12.0),
          Text(
            message ?? Translations.of(context).listIsEmpty,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
