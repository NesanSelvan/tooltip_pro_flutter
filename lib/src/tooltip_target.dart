import 'package:flutter/material.dart';
import 'package:tooltip_plus/src/tooltip_config.dart';
import 'package:tooltip_plus/src/tooltip_controller.dart';
import 'package:tooltip_plus/src/tooltip_enums.dart';
import 'package:tooltip_plus/src/tooltip_size.dart';

class TooltipTarget extends StatefulWidget {
  final Widget child;
  final TooltipDirection direction;
  final TooltipArrowDirection arrowDirection;

  /// Custom arrow offset (0.0 to 1.0) when arrowDirection is custom
  final double customArrowOffset;
  final Duration? autoDismiss;
  final double tooltipHeight;
  final double tooltipWidth;

  final double spacing;
  final double horizontalPadding;
  final double verticalPadding;
  final VoidCallback? onPressed;
  final Color? tooltipColor;
  final TooltipShadowConfig shadow;
  final TooltipBlurConfig blur;
  final TooltipBorderConfig border;
  final Widget? tooltipContent;
  final Widget Function(BuildContext context)? tooltipBuilder;

  const TooltipTarget({
    super.key,
    required this.child,
    this.direction = TooltipDirection.top,
    this.arrowDirection = TooltipArrowDirection.center,
    this.customArrowOffset = 0.5,
    this.autoDismiss = const Duration(seconds: 3),
    this.tooltipHeight = 50,
    this.tooltipWidth = 50,
    this.spacing = 10,
    this.horizontalPadding = 0,
    this.verticalPadding = 0,
    this.onPressed,
    this.tooltipColor,
    this.shadow = const TooltipShadowConfig(),
    this.blur = const TooltipBlurConfig(),
    this.border = const TooltipBorderConfig(),
    this.tooltipContent,
    this.tooltipBuilder,
  });

  @override
  State<TooltipTarget> createState() => TooltipTargetState();
}

class TooltipTargetState extends State<TooltipTarget> {
  final GlobalKey _targetKey = GlobalKey();
  late final TooltipController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TooltipController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Hide the tooltip programmatically
  void hideTooltip() {
    _controller.hide();
  }

  void _showTooltip() {
    _controller.show(
      context: context,
      targetKey: _targetKey,
      direction: widget.direction,
      arrowDirection: widget.arrowDirection,
      autoDismiss: widget.autoDismiss,
      tooltipColor: widget.tooltipColor,
      enableShadow: widget.shadow.enabled,
      shadowColor: widget.shadow.color,
      shadowElevation: widget.shadow.elevation,
      shadowBlurRadius: widget.shadow.blurRadius,
      blurBackground: widget.blur.enabled,
      blurSigma: widget.blur.sigma,
      blurColor: widget.blur.color,
      excludeChildFromBlur: !widget.blur.includeChild,
      childWidget: widget.child,
      enableBorder: widget.border.enabled,
      borderColor: widget.border.color,
      borderWidth: widget.border.width,
      borderRadius: widget.border.radius,
      customArrowOffset: widget.customArrowOffset,
      tooltipContent: widget.tooltipContent,
      tooltipBuilder: widget.tooltipBuilder,
      tooltipSize: TooltipSize(
        height: widget.tooltipHeight,
        width: widget.tooltipWidth,
        spacing: widget.spacing,
        horizontalPadding: widget.horizontalPadding,
        verticalPadding: widget.verticalPadding,
      ),
    );
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _targetKey,
      onTap: _showTooltip,
      child: widget.child,
    );
  }
}
