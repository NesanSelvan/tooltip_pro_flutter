import 'package:flutter/material.dart';

class TooltipShadowConfig {
  final bool enabled;
  final Color? color;
  final double elevation;
  final double blurRadius;

  const TooltipShadowConfig({
    this.enabled = false,
    this.color,
    this.elevation = 2.0,
    this.blurRadius = 4.0,
  });

  static const none = TooltipShadowConfig();
}

class TooltipBlurConfig {
  final bool enabled;
  final double sigma;
  final Color? color;
  final bool includeChild;

  const TooltipBlurConfig({
    this.enabled = false,
    this.sigma = 5.0,
    this.color,
    this.includeChild = false,
  });

  static const none = TooltipBlurConfig();
}

class TooltipBorderConfig {
  final bool enabled;
  final Color color;
  final double width;
  final double radius;

  const TooltipBorderConfig({
    this.enabled = false,
    this.color = Colors.black,
    this.width = 1.0,
    this.radius = 8.0,
  });

  static const none = TooltipBorderConfig();
}
