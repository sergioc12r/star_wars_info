
import 'package:flutter/material.dart';

mixin ScrollMixin<T extends StatefulWidget> on State<T> {

  ScrollController? controller = ScrollController();
  bool isLoading = false, hasReachedMax = false;
  double get scrollThreshold;

  @override
  void initState() {
    controller?.addListener(_verifyEndOfPage);
    super.initState();
  }

  onEndOfPage();

  onListenerScroll();

  void _verifyEndOfPage() {
    onListenerScroll();
    double maxScroll = controller?.position.maxScrollExtent ?? 0;
    double currentScroll = controller?.position.pixels ?? 0;
    double delta = scrollThreshold;
    if (maxScroll - currentScroll <= delta) {
      onEndOfPage();
    }
  }

  @override
  void dispose() {
    controller?.removeListener(_verifyEndOfPage);
    super.dispose();
  }
}