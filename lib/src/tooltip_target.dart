import 'package:flutter/material.dart';
import 'package:tooltip_pro/src/tooltip_config.dart';
import 'package:tooltip_pro/src/tooltip_controller.dart';
import 'package:tooltip_pro/src/tooltip_enums.dart';
import 'package:tooltip_pro/src/tooltip_size.dart';

class TooltipProController {
  TooltipProState? _state;

  bool get isVisible => _state?._isTooltipVisible ?? false;

  void show() {
    if (_state == null || !_state!.mounted) return;
    _state!._showTooltip();
  }

  void hide() {
    if (_state == null || !_state!.mounted) return;
    _state!.hideTooltip();
  }

  void _attach(TooltipProState state) {
    _state = state;
  }

  void _detach(TooltipProState state) {
    if (_state == state) {
      _state = null;
    }
  }
}

class TooltipPro extends StatefulWidget {
  final Widget child;
  final TooltipDirection direction;
  final TooltipCaretDirection caretDirection;

  final double customCaretOffset;
  final Duration? autoDismiss;
  final double? tooltipHeight;
  final double? tooltipWidth;
  final double caretWidth;
  final double caretHeight;

  final double spacing;
  final double horizontalPadding;
  final double verticalPadding;
  final VoidCallback? onPressed;
  final Color? tooltipColor;
  final TooltipShadowConfig shadow;
  final TooltipBlurConfig blur;
  final TooltipBorderConfig border;
  final TooltipAnimationConfig animation;
  final Widget? tooltipContent;
  final bool showAtTapPosition;
  final TooltipProTriggerMode triggerMode;
  final TooltipProController? controller;

  final Widget Function(BuildContext context, VoidCallback hideTooltip)?
  tooltipContentBuilder;

  final Widget Function(BuildContext context, VoidCallback hideTooltip)?
  tooltipBuilder;

  const TooltipPro({
    super.key,
    required this.child,
    this.direction = TooltipDirection.top,
    this.caretDirection = TooltipCaretDirection.center,
    this.customCaretOffset = 0.5,
    this.autoDismiss = const Duration(seconds: 3),
    this.tooltipHeight,
    this.tooltipWidth,
    this.spacing = 10,
    this.horizontalPadding = 0,
    this.verticalPadding = 0,
    this.onPressed,
    this.tooltipColor,
    this.shadow = const TooltipShadowConfig(),
    this.blur = const TooltipBlurConfig(),
    this.border = const TooltipBorderConfig(),
    this.animation = const TooltipAnimationConfig(),
    this.tooltipContent,
    this.tooltipContentBuilder,
    this.tooltipBuilder,
    this.caretWidth = 12.0,
    this.caretHeight = 10.0,
    this.showAtTapPosition = false,
    this.triggerMode = TooltipProTriggerMode.tap,
    this.controller,
  });

  /// A minimal tooltip with just text.
  /// good for short labels.
  factory TooltipPro.minimal({
    Key? key,
    required Widget child,
    required String text,
    TooltipDirection direction = TooltipDirection.top,
    TooltipCaretDirection caretDirection = TooltipCaretDirection.center,
    Duration? autoDismiss = const Duration(seconds: 3),
    double? tooltipHeight,
    double? tooltipWidth,
    double spacing = 10,
    double horizontalPadding = 0,
    double verticalPadding = 0,
    VoidCallback? onPressed,
    Color? tooltipColor,
    TooltipShadowConfig? shadow,
    TooltipBlurConfig blur = const TooltipBlurConfig(),
    TooltipBorderConfig? border,
    TooltipAnimationConfig animation = const TooltipAnimationConfig(),
    double customCaretOffset = 0.5,
    double caretWidth = 12.0,
    double caretHeight = 10.0,
    bool showAtTapPosition = false,
    TooltipProTriggerMode triggerMode = TooltipProTriggerMode.tap,
    TooltipProController? controller,
  }) {
    return TooltipPro(
      key: key,
      direction: direction,
      showAtTapPosition: showAtTapPosition,
      triggerMode: triggerMode,
      controller: controller,
      tooltipColor: tooltipColor ?? const Color(0xFF1E1E1E),
      tooltipHeight: tooltipHeight,
      tooltipWidth: tooltipWidth,
      caretDirection: caretDirection,
      customCaretOffset: customCaretOffset,
      autoDismiss: autoDismiss,
      spacing: spacing,
      horizontalPadding: horizontalPadding,
      verticalPadding: verticalPadding,
      onPressed: onPressed,
      blur: blur,
      border: border ?? const TooltipBorderConfig(radius: 4),
      animation: animation,
      tooltipContent: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
        textAlign: TextAlign.center,
      ),
      shadow:
          shadow ??
          const TooltipShadowConfig(enabled: true, blurRadius: 4, elevation: 2),
      caretWidth: caretWidth,
      caretHeight: caretHeight,
      child: child,
    );
  }

  /// A rich tooltip with a title, description, and icon.
  /// Styled with a modern "Info" look (blue accents).
  factory TooltipPro.rich({
    Key? key,
    required Widget child,
    required String title,
    required String description,
    IconData icon = Icons.info_outline_rounded,
    TooltipDirection direction = TooltipDirection.top,
    VoidCallback? onClose,
    TooltipCaretDirection caretDirection = TooltipCaretDirection.center,
    Duration? autoDismiss = const Duration(seconds: 3),
    double? tooltipHeight,
    double? tooltipWidth,
    double spacing = 10,
    double horizontalPadding = 0,
    double verticalPadding = 0,
    Color? tooltipColor,
    TooltipShadowConfig? shadow,
    TooltipBlurConfig blur = const TooltipBlurConfig(),
    TooltipBorderConfig? border,
    TooltipAnimationConfig animation = const TooltipAnimationConfig(),
    double customCaretOffset = 0.5,
    double caretWidth = 12.0,
    double caretHeight = 10.0,
    bool showAtTapPosition = false,
    TooltipProTriggerMode triggerMode = TooltipProTriggerMode.tap,
    TooltipProController? controller,
  }) {
    return TooltipPro(
      key: key,
      direction: direction,
      showAtTapPosition: showAtTapPosition,
      triggerMode: triggerMode,
      controller: controller,
      tooltipColor: tooltipColor ?? Colors.white,
      tooltipHeight: tooltipHeight,
      tooltipWidth: tooltipWidth,
      caretDirection: caretDirection,
      customCaretOffset: customCaretOffset,
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
      animation: animation,
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
      caretWidth: caretWidth,
      caretHeight: caretHeight,
      child: child,
    );
  }

  /// An error/alert tooltip styled with red accents.
  factory TooltipPro.error({
    Key? key,
    required Widget child,
    required String message,
    TooltipDirection direction = TooltipDirection.bottom,
    TooltipCaretDirection caretDirection = TooltipCaretDirection.left,
    Duration? autoDismiss = const Duration(seconds: 3),
    double? tooltipHeight,
    double? tooltipWidth,
    double spacing = 10,
    double horizontalPadding = 0,
    double verticalPadding = 0,
    VoidCallback? onPressed,
    Color? tooltipColor,
    TooltipShadowConfig? shadow,
    TooltipBlurConfig blur = const TooltipBlurConfig(),
    TooltipBorderConfig? border,
    TooltipAnimationConfig animation = const TooltipAnimationConfig(),
    double customCaretOffset = 0.2,
    double caretWidth = 12.0,
    double caretHeight = 10.0,
    bool showAtTapPosition = false,
    TooltipProTriggerMode triggerMode = TooltipProTriggerMode.tap,
    TooltipProController? controller,
  }) {
    return TooltipPro(
      key: key,
      direction: direction,
      showAtTapPosition: showAtTapPosition,
      triggerMode: triggerMode,
      controller: controller,
      tooltipColor: tooltipColor ?? const Color(0xFFFEF2F2),
      tooltipHeight: tooltipHeight,
      tooltipWidth: tooltipWidth,
      caretDirection: caretDirection,
      customCaretOffset: customCaretOffset,
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
      animation: animation,
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
      caretWidth: caretWidth,
      caretHeight: caretHeight,
      child: child,
    );
  }

  @override
  State<TooltipPro> createState() => TooltipProState();
}

class TooltipProState extends State<TooltipPro> {
  final GlobalKey _targetKey = GlobalKey();
  late final TooltipController _tooltipController;
  Offset? _tapPosition;

  bool get _isTooltipVisible => _tooltipController.isVisible;

  @override
  void initState() {
    super.initState();
    _tooltipController = TooltipController();
    widget.controller?._attach(this);
  }

  @override
  void didUpdateWidget(covariant TooltipPro oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?._detach(this);
      widget.controller?._attach(this);
    }
  }

  @override
  void dispose() {
    widget.controller?._detach(this);
    _tooltipController.dispose();
    super.dispose();
  }

  /// Hide the tooltip programmatically
  void hideTooltip() {
    _tooltipController.hide();
  }

  void _showTooltip({bool fromHold = false}) {
    _tooltipController.show(
      context: context,
      targetKey: _targetKey,
      direction: widget.direction,
      caretDirection: widget.caretDirection,
      autoDismiss: fromHold ? null : widget.autoDismiss,
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
      animation: widget.animation,
      customCaretOffset: widget.customCaretOffset,
      caretWidth: widget.caretWidth,
      caretHeight: widget.caretHeight,
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
      touchPoint: widget.showAtTapPosition ? _tapPosition : null,
    );
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    final bool supportsTap =
        widget.triggerMode == TooltipProTriggerMode.tap ||
        widget.triggerMode == TooltipProTriggerMode.tapAndHold;
    final bool supportsHold =
        widget.triggerMode == TooltipProTriggerMode.hold ||
        widget.triggerMode == TooltipProTriggerMode.tapAndHold;

    return GestureDetector(
      key: _targetKey,
      behavior: HitTestBehavior.translucent,
      onTapDown: (details) {
        _tapPosition = details.globalPosition;
      },
      onTap: supportsTap ? _showTooltip : null,
      onLongPressStart: supportsHold
          ? (details) {
              _tapPosition = details.globalPosition;
              _showTooltip(fromHold: true);
            }
          : null,
      onLongPressEnd: supportsHold ? (_) => hideTooltip() : null,
      onLongPressCancel: supportsHold ? hideTooltip : null,
      child: widget.child,
    );
  }
}
