import 'package:flutter/material.dart' hide TooltipTriggerMode;
import 'package:tooltip_pro/tooltip_pro.dart';

import 'example_widgets.dart';

const _tooltipBg = Color(0xFF0B0B0C);

const _premiumBorder = TooltipBorderConfig(
  enabled: true,
  color: Color(0x22FFFFFF),
  width: 1,
  radius: 14,
);

const _premiumTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 12.5,
  fontWeight: FontWeight.w600,
  height: 1.3,
  letterSpacing: 0.1,
);

const _subtleTextStyle = TextStyle(
  color: Color(0xFFD1D5DB),
  fontSize: 11.5,
  height: 1.4,
);

const _accentColor = Color(0xFFF97316);

final _premiumShadow = TooltipShadowConfig(
  enabled: true,
  color: const Color(0x66000000),
  blurRadius: 20,
  elevation: 8,
);

const _premiumAnimation = TooltipAnimationConfig(
  type: TooltipAnimationType.fadeScale,
  duration: Duration(milliseconds: 180),
  curve: TooltipAnimationCurve.easeOut,
);

// Helper: icon + label row used inside tooltips
Widget _iconLabel(
  IconData icon,
  String text, {
  Color iconColor = const Color(0xFF9CA3AF),
}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 14, color: iconColor),
      const SizedBox(width: 7),
      Text(text, style: _premiumTextStyle),
    ],
  );
}

// Padded tooltip body
Widget _tooltipBody(Widget content) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
    child: content,
  );
}

Widget _premiumTooltip({
  required Widget child,
  required Widget content,
  TooltipDirection direction = TooltipDirection.top,
  TooltipCaretDirection caretDirection = TooltipCaretDirection.center,
  double customCaretOffset = 0.5,
  double? width,
  double? height,
  double spacing = 12,
  double caretWidth = 14,
  double caretHeight = 10,
  TooltipProTriggerMode triggerMode = TooltipProTriggerMode.tap,
  Duration? autoDismiss = const Duration(seconds: 3),
  TooltipBlurConfig blur = const TooltipBlurConfig(),
  bool showAtTapPosition = false,
  TooltipAnimationConfig? animation,
}) {
  return TooltipPro(
    direction: direction,
    caretDirection: caretDirection,
    customCaretOffset: customCaretOffset,
    tooltipWidth: width,
    tooltipHeight: height,
    spacing: spacing,
    caretWidth: caretWidth,
    caretHeight: caretHeight,
    triggerMode: triggerMode,
    autoDismiss: autoDismiss,
    tooltipColor: _tooltipBg,
    border: _premiumBorder,
    shadow: _premiumShadow,
    animation: animation ?? _premiumAnimation,
    blur: blur,
    showAtTapPosition: showAtTapPosition,
    tooltipContent: _tooltipBody(content),
    child: child,
  );
}

// ──────────────────────────────────────────
// Sections
// ──────────────────────────────────────────

class FactorySection extends StatelessWidget {
  const FactorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoRow(
      children: [
        TooltipPro.minimal(
          text: 'Minimal tooltip',
          tooltipWidth: 150,
          tooltipColor: _tooltipBg,
          border: _premiumBorder,
          shadow: _premiumShadow,
          animation: _premiumAnimation,
          child: const DemoPill('minimal()', icon: Icons.short_text),
        ),
        TooltipPro.rich(
          title: 'Rich Tooltip',
          description: 'Title, description, and icon with a soft card layout.',
          tooltipWidth: 240,
          tooltipColor: Colors.white,
          border: const TooltipBorderConfig(
            enabled: true,
            color: Color(0xFFE5E7EB),
            width: 1,
            radius: 16,
          ),
          shadow: TooltipShadowConfig(
            enabled: true,
            color: const Color(0x22000000),
            blurRadius: 16,
            elevation: 6,
          ),
          child: const DemoPill('rich()', icon: Icons.info_outline),
        ),
        TooltipPro.error(
          message: 'Something went wrong. Try again.',
          tooltipWidth: 220,
          tooltipColor: const Color(0xFFFFF5F5),
          border: const TooltipBorderConfig(
            enabled: true,
            color: Color(0xFFFECACA),
            width: 1,
            radius: 14,
          ),
          shadow: TooltipShadowConfig(
            enabled: true,
            color: const Color(0x22000000),
            blurRadius: 12,
            elevation: 4,
          ),
          child: const DemoPill('error()', icon: Icons.warning_amber_rounded),
        ),
      ],
    );
  }
}

class DirectionsSection extends StatelessWidget {
  const DirectionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoRow(
      children: [
        _premiumTooltip(
          content: _iconLabel(Icons.arrow_forward_rounded, 'Points right'),
          direction: TooltipDirection.right,
          width: 155,
          child: const DemoPill('Right'),
        ),
        _premiumTooltip(
          content: _iconLabel(Icons.arrow_upward_rounded, 'Above target'),
          direction: TooltipDirection.top,
          width: 150,
          child: const DemoPill('Top'),
        ),
        _premiumTooltip(
          content: _iconLabel(Icons.arrow_downward_rounded, 'Below target'),
          direction: TooltipDirection.bottom,
          width: 150,
          child: const DemoPill('Bottom'),
        ),
        _premiumTooltip(
          content: _iconLabel(Icons.arrow_back_rounded, 'Points left'),
          direction: TooltipDirection.left,
          width: 145,
          child: const DemoPill('Left'),
        ),
      ],
    );
  }
}

class CaretSection extends StatelessWidget {
  const CaretSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoRow(
      children: [
        _premiumTooltip(
          content: _iconLabel(
            Icons.align_horizontal_left_rounded,
            'Caret on left',
          ),
          caretDirection: TooltipCaretDirection.left,
          width: 160,
          child: const DemoPill('Caret Left'),
        ),
        _premiumTooltip(
          content: _iconLabel(
            Icons.align_horizontal_center_rounded,
            'Caret centered',
          ),
          caretDirection: TooltipCaretDirection.center,
          width: 165,
          child: const DemoPill('Caret Center'),
        ),
        _premiumTooltip(
          content: _iconLabel(
            Icons.align_horizontal_right_rounded,
            'Caret on right',
          ),
          caretDirection: TooltipCaretDirection.right,
          width: 162,
          child: const DemoPill('Caret Right'),
        ),
        _premiumTooltip(
          content: _iconLabel(
            Icons.remove_circle_outline_rounded,
            'No caret shown',
          ),
          caretDirection: TooltipCaretDirection.none,
          width: 155,
          child: const DemoPill('No Caret'),
        ),
        _premiumTooltip(
          content: _iconLabel(Icons.tune_rounded, 'Offset at 30%'),
          caretDirection: TooltipCaretDirection.custom,
          customCaretOffset: 0.3,
          width: 148,
          child: const DemoPill('Custom Offset'),
        ),
      ],
    );
  }
}

class AnimationsSection extends StatelessWidget {
  const AnimationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoRow(
      children: [
        _premiumTooltip(
          content: _iconLabel(Icons.block_rounded, 'No animation'),
          width: 150,
          animation: const TooltipAnimationConfig(
            type: TooltipAnimationType.none,
          ),
          child: const DemoPill('None'),
          autoDismiss: const Duration(seconds: 2),
          spacing: 10,
        ),
        _premiumTooltip(
          content: _iconLabel(Icons.opacity_rounded, 'Fades in & out'),
          width: 155,
          animation: const TooltipAnimationConfig(
            type: TooltipAnimationType.fade,
            duration: Duration(milliseconds: 220),
          ),
          child: const DemoPill('Fade'),
        ),
        _premiumTooltip(
          content: _iconLabel(Icons.zoom_in_rounded, 'Scales in & out'),
          width: 155,
          animation: const TooltipAnimationConfig(
            type: TooltipAnimationType.scale,
            duration: Duration(milliseconds: 220),
          ),
          child: const DemoPill('Scale'),
        ),
        _premiumTooltip(
          content: _iconLabel(Icons.filter_rounded, 'Fade + scale combo'),
          width: 168,
          animation: const TooltipAnimationConfig(
            type: TooltipAnimationType.fadeScale,
            duration: Duration(milliseconds: 240),
          ),
          child: const DemoPill('FadeScale'),
        ),
        _premiumTooltip(
          content: _iconLabel(Icons.swap_vert_rounded, 'Slides into view'),
          width: 158,
          animation: const TooltipAnimationConfig(
            type: TooltipAnimationType.slide,
            duration: Duration(milliseconds: 240),
          ),
          child: const DemoPill('Slide'),
        ),
      ],
    );
  }
}

class TriggerSection extends StatelessWidget {
  const TriggerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoRow(
      children: [
        _premiumTooltip(
          content: _iconLabel(Icons.touch_app_rounded, 'Tap to show'),
          triggerMode: TooltipProTriggerMode.tap,
          width: 140,
          child: const DemoPill('Tap'),
        ),
        _premiumTooltip(
          content: _iconLabel(Icons.pan_tool_alt_rounded, 'Hold to show'),
          triggerMode: TooltipProTriggerMode.hold,
          width: 140,
          autoDismiss: null,
          child: const DemoPill('Hold'),
        ),
        _premiumTooltip(
          content: _iconLabel(Icons.gesture_rounded, 'Tap or hold'),
          triggerMode: TooltipProTriggerMode.tapAndHold,
          width: 140,
          child: const DemoPill('Tap & Hold'),
        ),
      ],
    );
  }
}

class BorderShadowSection extends StatelessWidget {
  const BorderShadowSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoRow(
      children: [
        TooltipPro(
          tooltipContent: _tooltipBody(
            _iconLabel(Icons.border_style_rounded, 'Subtle border'),
          ),
          tooltipColor: _tooltipBg,
          border: _premiumBorder,
          shadow: _premiumShadow,
          animation: _premiumAnimation,
          tooltipWidth: 162,
          child: const DemoPill('Border'),
        ),
        TooltipPro(
          tooltipContent: _tooltipBody(
            _iconLabel(Icons.layers_rounded, 'Deep shadow'),
          ),
          tooltipColor: _tooltipBg,
          animation: _premiumAnimation,
          shadow: TooltipShadowConfig(
            enabled: true,
            color: const Color(0x66000000),
            blurRadius: 24,
            elevation: 14,
          ),
          tooltipWidth: 150,
          child: const DemoPill('Shadow'),
        ),
        TooltipPro(
          tooltipContent: _tooltipBody(
            _iconLabel(Icons.circle_outlined, 'Pill shape'),
          ),
          tooltipColor: _tooltipBg,
          animation: _premiumAnimation,
          border: const TooltipBorderConfig(
            enabled: true,
            color: Color(0x33FFFFFF),
            width: 1,
            radius: 999,
          ),
          shadow: _premiumShadow,
          tooltipWidth: 140,
          child: const DemoPill('Pill'),
        ),
        TooltipPro(
          tooltipContent: _tooltipBody(
            _iconLabel(Icons.blur_circular_rounded, 'Glass style'),
          ),
          tooltipColor: const Color(0xCC111827),
          animation: _premiumAnimation,
          border: const TooltipBorderConfig(
            enabled: true,
            color: Color(0x44FFFFFF),
            width: 1,
            radius: 14,
          ),
          shadow: TooltipShadowConfig(
            enabled: true,
            color: const Color(0x33000000),
            blurRadius: 20,
            elevation: 10,
          ),
          tooltipWidth: 148,
          child: const DemoPill('Glass'),
        ),
      ],
    );
  }
}

class BlurSection extends StatelessWidget {
  const BlurSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoRow(
      children: [
        _premiumTooltip(
          content: _iconLabel(Icons.blur_on_rounded, 'Blurred backdrop'),
          blur: const TooltipBlurConfig(
            enabled: true,
            sigma: 8,
            color: Color(0x22000000),
          ),
          width: 168,
          child: const DemoPill('Blurred'),
        ),
      ],
    );
  }
}

class CaretSizeSection extends StatelessWidget {
  const CaretSizeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoRow(
      children: [
        _premiumTooltip(
          content: _iconLabel(Icons.zoom_out_rounded, 'Compact caret'),
          caretWidth: 10,
          caretHeight: 6,
          width: 158,
          child: const DemoPill('Compact'),
        ),
        _premiumTooltip(
          content: _iconLabel(Icons.zoom_in_rounded, 'Large caret'),
          caretWidth: 22,
          caretHeight: 16,
          width: 145,
          child: const DemoPill('Large'),
        ),
      ],
    );
  }
}

class AutoDismissSection extends StatelessWidget {
  const AutoDismissSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoRow(
      children: [
        _premiumTooltip(
          content: _iconLabel(Icons.timer_rounded, 'Hides after 2s'),
          width: 165,
          autoDismiss: const Duration(seconds: 2),
          child: const DemoPill('2s'),
        ),
        _premiumTooltip(
          content: _iconLabel(
            Icons.all_inclusive_rounded,
            'Stays until dismissed',
          ),
          width: 195,
          autoDismiss: null,
          child: const DemoPill('Persistent'),
        ),
      ],
    );
  }
}

class TapPositionSection extends StatelessWidget {
  const TapPositionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoRow(
      children: [
        _premiumTooltip(
          content: _iconLabel(Icons.ads_click_rounded, 'Follows tap point'),
          width: 170,
          showAtTapPosition: true,
          child: const DemoPill('Tap anywhere'),
        ),
      ],
    );
  }
}

class CustomContentSection extends StatelessWidget {
  const CustomContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoRow(
      children: [
        TooltipPro(
          tooltipWidth: 230,
          tooltipHeight: 250,
          tooltipColor: _tooltipBg,
          border: _premiumBorder,
          shadow: _premiumShadow,
          animation: _premiumAnimation,
          tooltipContent: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1C1E),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Icon(
                        Icons.restaurant_rounded,
                        size: 13,
                        color: _accentColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('Weekly nutrition', style: _premiumTextStyle),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'Scan labels to auto-calculate daily macros.',
                  style: _subtleTextStyle,
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=400&q=60',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          child: const DemoPill('Custom Card', icon: Icons.auto_awesome),
        ),
      ],
    );
  }
}

class TooltipBuilderSection extends StatelessWidget {
  const TooltipBuilderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoRow(
      children: [
        TooltipPro(
          tooltipWidth: 210,
          tooltipBuilder: (context, hide) {
            return Container(
              decoration: BoxDecoration(
                color: _tooltipBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0x22FFFFFF)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x55000000),
                    blurRadius: 18,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
                    decoration: const BoxDecoration(
                      color: Color(0xFF111111),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1C1C1E),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Icon(
                            Icons.dashboard_customize_rounded,
                            size: 13,
                            color: _accentColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text('Builder tooltip', style: _premiumTextStyle),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Custom layouts with buttons and actions.',
                          style: _subtleTextStyle,
                        ),
                        const SizedBox(height: 12),
                        OrangeFilledButton(
                          onPressed: hide,
                          child: const Text('Got it'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          child: const DemoPill('Builder', icon: Icons.dashboard_customize),
        ),
      ],
    );
  }
}

class ControllerSection extends StatefulWidget {
  const ControllerSection({super.key});

  @override
  State<ControllerSection> createState() => _ControllerSectionState();
}

class _ControllerSectionState extends State<ControllerSection> {
  final TooltipProController _controller = TooltipProController();

  @override
  Widget build(BuildContext context) {
    return DemoRow(
      children: [
        TooltipPro(
          controller: _controller,
          tooltipWidth: 210,
          tooltipColor: _tooltipBg,
          border: _premiumBorder,
          shadow: _premiumShadow,
          animation: _premiumAnimation,
          tooltipContent: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1C1E),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Icon(
                        Icons.tune_rounded,
                        size: 13,
                        color: _accentColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('Controller', style: _premiumTextStyle),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'Driven by TooltipProController.',
                  style: _subtleTextStyle,
                ),
              ],
            ),
          ),
          child: const DemoPill('Target', icon: Icons.tune),
        ),
        OrangeFilledButton(
          onPressed: _controller.show,
          child: const Text('Show'),
        ),
        OrangeOutlinedButton(
          onPressed: _controller.hide,
          child: const Text('Hide'),
        ),
      ],
    );
  }
}
