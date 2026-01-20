import 'package:flutter/material.dart';
import 'package:tooltip_plus_flutter/src/tooltip_config.dart';
import 'package:tooltip_plus_flutter/src/tooltip_controller.dart';
import 'package:tooltip_plus_flutter/src/tooltip_enums.dart';
import 'package:tooltip_plus_flutter/src/tooltip_size.dart';

class TooltipTarget extends StatefulWidget {
  final Widget child;
  final TooltipDirection direction;
  final TooltipArrowDirection arrowDirection;

  final double customArrowOffset;
  final Duration? autoDismiss;
  final double tooltipHeight;
  final double tooltipWidth;
  final double arrowWidth;
  final double arrowHeight;

  final double spacing;
  final double horizontalPadding;
  final double verticalPadding;
  final VoidCallback? onPressed;
  final Color? tooltipColor;
  final TooltipShadowConfig shadow;
  final TooltipBlurConfig blur;
  final TooltipBorderConfig border;
  final Widget? tooltipContent;

  final Widget Function(BuildContext context, VoidCallback hideTooltip)?
  tooltipContentBuilder;

  final Widget Function(BuildContext context, VoidCallback hideTooltip)?
  tooltipBuilder;

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
    this.tooltipContentBuilder,
    this.tooltipBuilder,
    this.arrowWidth = 12.0,
    this.arrowHeight = 10.0,
  });

  /// A minimal tooltip with just text.
  /// good for short labels.
  factory TooltipTarget.minimal({
    Key? key,
    required Widget child,
    required String text,
    TooltipDirection direction = TooltipDirection.top,
    TooltipArrowDirection arrowDirection = TooltipArrowDirection.center,
    Duration? autoDismiss = const Duration(seconds: 3),
    double tooltipHeight = 40,
    double tooltipWidth = 100,
    double spacing = 10,
    double horizontalPadding = 0,
    double verticalPadding = 0,
    VoidCallback? onPressed,
    Color? tooltipColor,
    TooltipShadowConfig? shadow,
    TooltipBlurConfig blur = const TooltipBlurConfig(),
    TooltipBorderConfig? border,
    double customArrowOffset = 0.5,
    double arrowWidth = 12.0,
    double arrowHeight = 10.0,
  }) {
    return TooltipTarget(
      key: key,
      direction: direction,
      tooltipColor: tooltipColor ?? const Color(0xFF1E1E1E),
      tooltipHeight: tooltipHeight,
      tooltipWidth: tooltipWidth,
      arrowDirection: arrowDirection,
      customArrowOffset: customArrowOffset,
      autoDismiss: autoDismiss,
      spacing: spacing,
      horizontalPadding: horizontalPadding,
      verticalPadding: verticalPadding,
      onPressed: onPressed,
      blur: blur,
      border: border ?? const TooltipBorderConfig(radius: 4),
      tooltipContent: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
        textAlign: TextAlign.center,
      ),
      shadow:
          shadow ??
          const TooltipShadowConfig(enabled: true, blurRadius: 4, elevation: 2),
      arrowWidth: arrowWidth,
      arrowHeight: arrowHeight,
      child: child,
    );
  }

  /// A rich tooltip with a title, description, and icon.
  /// Styled with a modern "Info" look (blue accents).
  factory TooltipTarget.rich({
    Key? key,
    required Widget child,
    required String title,
    required String description,
    IconData icon = Icons.info_outline_rounded,
    TooltipDirection direction = TooltipDirection.top,
    VoidCallback? onClose,
    TooltipArrowDirection arrowDirection = TooltipArrowDirection.center,
    Duration? autoDismiss = const Duration(seconds: 3),
    double tooltipHeight = 90,
    double tooltipWidth = 220,
    double spacing = 10,
    double horizontalPadding = 0,
    double verticalPadding = 0,
    Color? tooltipColor,
    TooltipShadowConfig? shadow,
    TooltipBlurConfig blur = const TooltipBlurConfig(),
    TooltipBorderConfig? border,
    double customArrowOffset = 0.5,
    double arrowWidth = 12.0,
    double arrowHeight = 10.0,
  }) {
    return TooltipTarget(
      key: key,
      direction: direction,
      tooltipColor: tooltipColor ?? Colors.white,
      tooltipHeight: tooltipHeight,
      tooltipWidth: tooltipWidth,
      arrowDirection: arrowDirection,
      customArrowOffset: customArrowOffset,
      onPressed: onClose,
      autoDismiss: autoDismiss,
      spacing: spacing,
      horizontalPadding: horizontalPadding,
      verticalPadding: verticalPadding,
      blur: blur,
      border:
          border ??
          const TooltipBorderConfig(
            enabled: true,
            color: Color(0xFFE0E0E0),
            width: 1,
            radius: 12,
          ),
      shadow:
          shadow ??
          TooltipShadowConfig(
            enabled: true,
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            elevation: 5,
          ),
      tooltipContentBuilder: (context, hideTooltip) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.blue, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      arrowWidth: arrowWidth,
      arrowHeight: arrowHeight,
      child: child,
    );
  }

  /// An error/alert tooltip styled with red accents.
  factory TooltipTarget.error({
    Key? key,
    required Widget child,
    required String message,
    TooltipDirection direction = TooltipDirection.bottom,
    TooltipArrowDirection arrowDirection = TooltipArrowDirection.left,
    Duration? autoDismiss = const Duration(seconds: 3),
    double tooltipHeight = 60,
    double tooltipWidth = 180,
    double spacing = 10,
    double horizontalPadding = 0,
    double verticalPadding = 0,
    VoidCallback? onPressed,
    Color? tooltipColor,
    TooltipShadowConfig? shadow,
    TooltipBlurConfig blur = const TooltipBlurConfig(),
    TooltipBorderConfig? border,
    double customArrowOffset = 0.2,
    double arrowWidth = 12.0,
    double arrowHeight = 10.0,
  }) {
    return TooltipTarget(
      key: key,
      direction: direction,
      tooltipColor: tooltipColor ?? const Color(0xFFFEF2F2),
      tooltipHeight: tooltipHeight,
      tooltipWidth: tooltipWidth,
      arrowDirection: arrowDirection,
      customArrowOffset: customArrowOffset,
      autoDismiss: autoDismiss,
      spacing: spacing,
      horizontalPadding: horizontalPadding,
      verticalPadding: verticalPadding,
      onPressed: onPressed,
      blur: blur,
      border:
          border ??
          const TooltipBorderConfig(
            enabled: true,
            color: Color(0xFFFECACA),
            width: 1,
            radius: 8,
          ),
      shadow: shadow ?? const TooltipShadowConfig(),
      tooltipContentBuilder: (context, hide) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              const Icon(
                Icons.error_outline_rounded,
                color: Colors.red,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Color(0xFF991B1B), // Dark red text
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      arrowWidth: arrowWidth,
      arrowHeight: arrowHeight,
      child: child,
    );
  }

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
      arrowWidth: widget.arrowWidth,
      arrowHeight: widget.arrowHeight,
      tooltipContent: widget.tooltipContent,
      tooltipContentBuilder: widget.tooltipContentBuilder,
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
