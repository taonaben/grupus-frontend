import 'package:flutter/material.dart';
import 'package:grupus/shared/constants/app_constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double? size;

  @override
  const CustomProgressIndicator({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.waveDots(
      color: Theme.of(context).colorScheme.primary,
      size: size ?? AppConstants.progressIndicatorSizeMedium,
    );
  }
}
