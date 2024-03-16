import 'package:finding_your_movies_demo/l10n/translations.dart';
import 'package:finding_your_movies_demo/resource/widgets/refresh_and_loadmore_widget.dart';
import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String? message;
  final Future<void> Function()? onLoadmore;
  const ErrorMessage({super.key, this.message, this.onLoadmore});

  @override
  Widget build(BuildContext context) {
    return RefreshAndLoadmoreWidget(
      onLoadmore: onLoadmore,
      child: ListView(
        padding: EdgeInsets.fromLTRB(
            16.0, MediaQuery.of(context).size.height * 0.45, 16.0, 24.0),
        children: [
          const Icon(
            Icons.report_problem_rounded,
            color: Colors.grey,
          ),
          const SizedBox(height: 12.0),
          Text(
            message ?? Translations.of(context).anErrorHasOccurredPleaseTryAgain,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
