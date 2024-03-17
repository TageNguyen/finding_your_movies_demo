import 'package:finding_your_movies_demo/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshAndLoadmoreWidget extends StatefulWidget {
  final Widget child;
  final Future<void> Function()? onRefresh;
  final Future<void> Function()? onLoadmore;
  final Color? waterDropColor;
  final Color? waterDropBackgroundColor;
  const RefreshAndLoadmoreWidget(
      {required this.child,
      this.onRefresh,
      this.onLoadmore,
      this.waterDropColor,
      this.waterDropBackgroundColor,
      super.key});

  @override
  State<RefreshAndLoadmoreWidget> createState() => _RefreshAndLoadmoreWidgetState();
}

class _RefreshAndLoadmoreWidgetState extends State<RefreshAndLoadmoreWidget> {
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: true,
      enablePullDown: widget.onRefresh != null,
      footer: CustomFooter(
        builder: (context, loadStatus) {
          if (loadStatus == LoadStatus.loading) {
            return Center(
              child: Transform.scale(
                scale: 0.5,
                child: const CircularProgressIndicator(
                  strokeWidth: 2.0,
                  color: AppColors.white,
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      header: WaterDropMaterialHeader(
        color: widget.waterDropColor ?? Theme.of(context).colorScheme.secondary,
        backgroundColor:
            widget.waterDropBackgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      ),
      onLoading: () async {
        _refreshController.requestLoading();
        await widget.onLoadmore?.call();
        _refreshController.loadComplete();
      },
      onRefresh: () async {
        _refreshController.requestRefresh();
        await widget.onRefresh?.call();
        _refreshController.refreshCompleted();
      },
      child: widget.child,
    );
  }
}
