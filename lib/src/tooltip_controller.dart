import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tooltip_pro/src/tooltip_content.dart';
import 'package:tooltip_pro/src/tooltip_config.dart';
import 'package:tooltip_pro/src/tooltip_enums.dart';
import 'package:tooltip_pro/src/tooltip_size.dart';

class TooltipController {
  OverlayEntry? _backgroundEntry;
  OverlayEntry? _childEntry;
  OverlayEntry? _overlayEntry;
  VoidCallback? _onDismiss;
  Timer? _dismissTimer;

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
    TooltipAnimationConfig animation = const TooltipAnimationConfig(),
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
    Offset? touchPoint,
  }) {
    hide();
    _dismissTimer?.cancel();
    _onDismiss = onDismiss;

    final RenderBox? renderBox =
        targetKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final targetSize = renderBox.size;

    final centerPosition =
        touchPoint ??
        Offset(
          position.dx + targetSize.width / 2,
          position.dy + targetSize.height / 2,
        );

    final screenSize = MediaQuery.of(context).size;

    final ValueNotifier<Size> tooltipMeasuredSize = ValueNotifier(
      Size(
        tooltipSize.width ?? 0,
        tooltipSize.height ?? 0,
      ),
    );

    final bool needsMeasurement =
        tooltipSize.width == null || tooltipSize.height == null;

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

    Widget tooltipChild = _buildAnimatedTooltip(
      context: context,
      tooltipBuilder: tooltipBuilder,
      animation: animation,
      direction: direction,
      tooltipContent: tooltipContent,
      tooltipContentBuilder: tooltipContentBuilder,
      tooltipColor: tooltipColor,
      arrowDirection: arrowDirection,
      tooltipSize: tooltipSize,
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
    );

    if (needsMeasurement) {
      tooltipChild = _TooltipSizeReporter(
        onSizeChange: (size) {
          if (size == tooltipMeasuredSize.value) return;
          tooltipMeasuredSize.value = size;
        },
        child: tooltipChild,
      );
    }

    _overlayEntry = OverlayEntry(
      builder: (ctx) => ValueListenableBuilder<Size>(
        valueListenable: tooltipMeasuredSize,
        builder: (context, measuredSize, child) {
          final Size effectiveSize = Size(
            tooltipSize.width ?? measuredSize.width,
            tooltipSize.height ?? measuredSize.height,
          );
          final tooltipPosition = _calculatePosition(
            centerPosition,
            direction,
            tooltipSize,
            effectiveSize,
            screenSize,
          );

          return Positioned(
            left: tooltipPosition.dx,
            top: tooltipPosition.dy,
            child: child!,
          );
        },
        child: tooltipChild,
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);

    if (autoDismiss != null) {
      _dismissTimer = Timer(autoDismiss, () {
        hide();
      });
    }
  }

  void hide() {
    _dismissTimer?.cancel();
    _dismissTimer = null;
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
    Size tooltipSize,
    Size screenSize,
  ) {
    double x, y;
    final double width = tooltipSize.width;
    final double height = tooltipSize.height;

    switch (direction) {
      case TooltipDirection.top:
        x = targetCenter.dx - width / 2;
        y = targetCenter.dy - height - size.spacing;
        break;
      case TooltipDirection.bottom:
        x = targetCenter.dx - width / 2;
        y = targetCenter.dy + size.spacing;
        break;
      case TooltipDirection.left:
        x = targetCenter.dx - width - size.spacing;
        y = targetCenter.dy - height / 2;
        break;
      case TooltipDirection.right:
        x = targetCenter.dx + size.spacing;
        y = targetCenter.dy - height / 2;
        break;
    }

    // Apply padding constraints
    final minX = size.horizontalPadding;
    final maxX = screenSize.width - width - size.horizontalPadding;
    final minY = size.verticalPadding;
    final maxY = screenSize.height - height - size.verticalPadding;

    x = x.clamp(minX, maxX);
    y = y.clamp(minY, maxY);

    return Offset(x, y);
  }

  void dispose() {
    hide();
  }

  Widget _buildAnimatedTooltip({
    required BuildContext context,
    required TooltipAnimationConfig animation,
    required TooltipDirection direction,
    required TooltipArrowDirection arrowDirection,
    required TooltipSize tooltipSize,
    required bool enableShadow,
    required Color? shadowColor,
    required double shadowElevation,
    required double shadowBlurRadius,
    required bool enableBorder,
    required Color borderColor,
    required double borderWidth,
    required double borderRadius,
    required double arrowWidth,
    required double arrowHeight,
    required double customArrowOffset,
    required Widget? tooltipContent,
    required Widget Function(BuildContext context, VoidCallback hideTooltip)?
        tooltipContentBuilder,
    required Widget Function(BuildContext context, VoidCallback hideTooltip)?
        tooltipBuilder,
    required Color? tooltipColor,
  }) {
    final Widget content = tooltipBuilder != null
        ? tooltipBuilder(context, hide)
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
                ? tooltipContentBuilder(context, hide)
                : tooltipContent,
          );

    if (animation.type == TooltipAnimationType.none) {
      return content;
    }

    return TweenAnimationBuilder<double>(
      duration: animation.duration,
      curve: _resolveCurve(animation.curve),
      tween: Tween(begin: 0, end: 1),
      builder: (context, value, child) {
        final double clampedValue = value.clamp(0.0, 1.0);
        switch (animation.type) {
          case TooltipAnimationType.fade:
            return Opacity(opacity: clampedValue, child: child);
          case TooltipAnimationType.scale:
            return Transform.scale(
              scale: 0.95 + (0.05 * clampedValue),
              child: child,
            );
          case TooltipAnimationType.fadeScale:
            return Opacity(
              opacity: clampedValue,
              child: Transform.scale(
                scale: 0.95 + (0.05 * clampedValue),
                child: child,
              ),
            );
          case TooltipAnimationType.slide:
            final offset = _slideOffset(direction);
            return Transform.translate(
              offset: Offset(
                offset.dx * (1 - clampedValue),
                offset.dy * (1 - clampedValue),
              ),
              child: child,
            );
          case TooltipAnimationType.none:
            return child!;
        }
      },
      child: content,
    );
  }

  Offset _slideOffset(TooltipDirection direction) {
    const distance = 8.0;
    switch (direction) {
      case TooltipDirection.top:
        return const Offset(0, distance);
      case TooltipDirection.bottom:
        return const Offset(0, -distance);
      case TooltipDirection.left:
        return const Offset(distance, 0);
      case TooltipDirection.right:
        return const Offset(-distance, 0);
    }
  }

  Curve _resolveCurve(TooltipAnimationCurve curve) {
    switch (curve) {
      case TooltipAnimationCurve.easeIn:
        return Curves.easeIn;
      case TooltipAnimationCurve.easeOut:
        return Curves.easeOut;
    }
  }
}

class _TooltipSizeReporter extends SingleChildRenderObjectWidget {
  final ValueChanged<Size> onSizeChange;

  const _TooltipSizeReporter({
    required this.onSizeChange,
    required Widget child,
  }) : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _TooltipSizeReporterRenderObject(onSizeChange);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _TooltipSizeReporterRenderObject renderObject,
  ) {
    renderObject.onSizeChange = onSizeChange;
  }
}

class _TooltipSizeReporterRenderObject extends RenderProxyBox {
  _TooltipSizeReporterRenderObject(this.onSizeChange);

  ValueChanged<Size> onSizeChange;
  Size? _lastSize;

  @override
  void performLayout() {
    super.performLayout();
    final Size newSize = size;
    if (_lastSize == newSize) return;
    _lastSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onSizeChange(newSize);
    });
  }
}
