import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tooltip_plus_flutter/src/tooltip_content.dart';
import 'package:tooltip_plus_flutter/src/tooltip_enums.dart';
import 'package:tooltip_plus_flutter/src/tooltip_size.dart';

class TooltipController {
  OverlayEntry? _backgroundEntry;
  OverlayEntry? _childEntry;
  OverlayEntry? _overlayEntry;
  VoidCallback? _onDismiss;

  bool get isVisible => _overlayEntry != null;

  TooltipController();

  void show({
    required BuildContext context,
    required GlobalKey targetKey,
    TooltipDirection direction = TooltipDirection.top,
    TooltipArrowDirection arrowDirection = TooltipArrowDirection.center,
    Color? tooltipColor,
    bool enableShadow = false,
    Color? shadowColor,
    double shadowElevation = 2.0,
    double shadowBlurRadius = 4.0,
    bool enableBorder = false,
    Color borderColor = Colors.black,
    double borderWidth = 1.0,
    double borderRadius = 8.0,
    double customArrowOffset = 0.5,
    Widget? tooltipContent,
    Widget Function(BuildContext context, VoidCallback hideTooltip)?
    tooltipContentBuilder,
    bool blurBackground = false,
    double blurSigma = 5.0,
    Color? blurColor,
    bool excludeChildFromBlur = true,
    Widget? childWidget,
    Widget Function(BuildContext context, VoidCallback hideTooltip)?
    tooltipBuilder,
    Duration? autoDismiss = const Duration(seconds: 3),
    TooltipSize tooltipSize = const TooltipSize(),
    VoidCallback? onDismiss,
    double arrowWidth = 12.0,
    double arrowHeight = 10.0,
  }) {
    hide();
    _onDismiss = onDismiss;

    final RenderBox? renderBox =
        targetKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final targetSize = renderBox.size;

    final centerPosition = Offset(
      position.dx + targetSize.width / 2,
      position.dy + targetSize.height / 2,
    );

    final screenSize = MediaQuery.of(context).size;

    final tooltipPosition = _calculatePosition(
      centerPosition,
      direction,
      tooltipSize,
      screenSize,
    );

    if (blurBackground) {
      _backgroundEntry = OverlayEntry(
        builder: (context) => Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
            child: Container(
              color: blurColor ?? Colors.black.withValues(alpha: 0.1),
            ),
          ),
        ),
      );
      Overlay.of(context).insert(_backgroundEntry!);

      if (excludeChildFromBlur && childWidget != null) {
        _childEntry = OverlayEntry(
          builder: (context) => Positioned(
            left: position.dx,
            top: position.dy,
            width: targetSize.width,
            height: targetSize.height,
            child: childWidget,
          ),
        );
        Overlay.of(context).insert(_childEntry!);
      }
    }

    _overlayEntry = OverlayEntry(
      builder: (ctx) => Positioned(
        left: tooltipPosition.dx,
        top: tooltipPosition.dy,
        child: tooltipBuilder != null
            ? tooltipBuilder(ctx, hide)
            : TooltipContent(
                tooltipColor: tooltipColor,
                arrowDirection: arrowDirection,
                height: tooltipSize.height,
                width: tooltipSize.width,
                direction: direction,
                enableShadow: enableShadow,
                shadowColor: shadowColor,
                shadowElevation: shadowElevation,
                shadowBlurRadius: shadowBlurRadius,
                enableBorder: enableBorder,
                borderColor: borderColor,
                borderWidth: borderWidth,
                borderRadius: borderRadius,
                arrowWidth: arrowWidth,
                arrowHeight: arrowHeight,
                customArrowOffset: customArrowOffset,
                content: tooltipContentBuilder != null
                    ? tooltipContentBuilder(ctx, hide)
                    : tooltipContent,
              ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);

    if (autoDismiss != null) {
      Future.delayed(autoDismiss, () {
        hide();
      });
    }
  }

  void hide() {
    _backgroundEntry?.remove();
    _backgroundEntry = null;
    _childEntry?.remove();
    _childEntry = null;
    _overlayEntry?.remove();
    _overlayEntry = null;
    _onDismiss?.call();
    _onDismiss = null;
  }

  Offset _calculatePosition(
    Offset targetCenter,
    TooltipDirection direction,
    TooltipSize size,
    Size screenSize,
  ) {
    double x, y;

    switch (direction) {
      case TooltipDirection.top:
        x = targetCenter.dx - size.width / 2;
        y = targetCenter.dy - size.height - size.spacing;
        break;
      case TooltipDirection.bottom:
        x = targetCenter.dx - size.width / 2;
        y = targetCenter.dy + size.spacing;
        break;
      case TooltipDirection.left:
        x = targetCenter.dx - size.width - size.spacing;
        y = targetCenter.dy - size.height / 2;
        break;
      case TooltipDirection.right:
        x = targetCenter.dx + size.spacing;
        y = targetCenter.dy - size.height / 2;
        break;
    }

    // Apply padding constraints
    final minX = size.horizontalPadding;
    final maxX = screenSize.width - size.width - size.horizontalPadding;
    final minY = size.verticalPadding;
    final maxY = screenSize.height - size.height - size.verticalPadding;

    x = x.clamp(minX, maxX);
    y = y.clamp(minY, maxY);

    return Offset(x, y);
  }

  void dispose() {
    hide();
  }
}
