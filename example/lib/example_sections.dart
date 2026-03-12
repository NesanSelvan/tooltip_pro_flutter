import 'package:flutter/material.dart' hide TooltipTriggerMode;
import 'package:tooltip_pro/tooltip_pro.dart';

import 'example_widgets.dart';

const _premiumTooltipColor = Color(0xFF0B0B0C);
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
  letterSpacing: 0.2,
);
const _subtleTextStyle = TextStyle(
  color: Color(0xFFE5E7EB),
  fontSize: 12,
  height: 1.3,
);

final _premiumShadow = TooltipShadowConfig(
  enabled: true,
  color: const Color(0x66000000),
  blurRadius: 18,
  elevation: 8,
);

const _premiumAnimation = TooltipAnimationConfig(
  type: TooltipAnimationType.fadeScale,
  duration: Duration(milliseconds: 180),
  curve: TooltipAnimationCurve.easeOut,
);

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
    tooltipColor: _premiumTooltipColor,
    border: _premiumBorder,
    shadow: _premiumShadow,
    animation: animation ?? _premiumAnimation,
    blur: blur,
    showAtTapPosition: showAtTapPosition,
    tooltipContent: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: content,
    ),
    child: child,
  );
}

class FactorySection extends StatelessWidget {
  const FactorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoRow(
      children: [
        TooltipPro.minimal(
          text: 'Minimal tooltip',
          tooltipWidth: 150,
          tooltipColor: _premiumTooltipColor,
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
          content: const Text('Right aligned', style: _premiumTextStyle),
          direction: TooltipDirection.right,
          width: 140,
          child: const DemoPill('Right'),
        ),
        _premiumTooltip(
          content: const Text('Above the target', style: _premiumTextStyle),
          direction: TooltipDirection.top,
          width: 160,
          child: const DemoPill('Top'),
        ),
        _premiumTooltip(
          content: const Text('Below the target', style: _premiumTextStyle),
          direction: TooltipDirection.bottom,
          width: 160,
          child: const DemoPill('Bottom'),
        ),
        _premiumTooltip(
          content: const Text('Left aligned', style: _premiumTextStyle),
          direction: TooltipDirection.left,
          width: 140,
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
          content: const Text('Caret on left', style: _premiumTextStyle),
          caretDirection: TooltipCaretDirection.left,
          width: 150,
          child: const DemoPill('Caret Left'),
        ),
        _premiumTooltip(
          content: const Text('Caret centered', style: _premiumTextStyle),
          caretDirection: TooltipCaretDirection.center,
          width: 150,
          child: const DemoPill('Caret Center'),
        ),
        _premiumTooltip(
          content: const Text('Caret on right', style: _premiumTextStyle),
          caretDirection: TooltipCaretDirection.right,
          width: 150,
          child: const DemoPill('Caret Right'),
        ),
        _premiumTooltip(
          content: const Text('No caret', style: _premiumTextStyle),
          caretDirection: TooltipCaretDirection.none,
          width: 120,
          child: const DemoPill('No Caret'),
        ),
        _premiumTooltip(
          content: const Text('Custom 30%', style: _premiumTextStyle),
          caretDirection: TooltipCaretDirection.custom,
          customCaretOffset: 0.3,
          width: 140,
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
          content: const Text('No animation', style: _premiumTextStyle),
          width: 140,
          animation: const TooltipAnimationConfig(
            type: TooltipAnimationType.none,
          ),
          child: const DemoPill('None'),
          autoDismiss: const Duration(seconds: 2),
          spacing: 10,
        ),
        _premiumTooltip(
          content: const Text('Fade', style: _premiumTextStyle),
          width: 100,
          animation: const TooltipAnimationConfig(
            type: TooltipAnimationType.fade,
            duration: Duration(milliseconds: 220),
          ),
          child: const DemoPill('Fade'),
        ),
        _premiumTooltip(
          content: const Text('Scale', style: _premiumTextStyle),
          width: 100,
          animation: const TooltipAnimationConfig(
            type: TooltipAnimationType.scale,
            duration: Duration(milliseconds: 220),
          ),
          child: const DemoPill('Scale'),
        ),
        _premiumTooltip(
          content: const Text('Fade + Scale', style: _premiumTextStyle),
          width: 140,
          animation: const TooltipAnimationConfig(
            type: TooltipAnimationType.fadeScale,
            duration: Duration(milliseconds: 240),
          ),
          child: const DemoPill('FadeScale'),
        ),
        _premiumTooltip(
          content: const Text('Slide', style: _premiumTextStyle),
          width: 100,
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
          content: const Text('Tap to show', style: _premiumTextStyle),
          triggerMode: TooltipProTriggerMode.tap,
          width: 120,
          child: const DemoPill('Tap'),
        ),
        _premiumTooltip(
          content: const Text('Hold to show', style: _premiumTextStyle),
          triggerMode: TooltipProTriggerMode.hold,
          width: 120,
          autoDismiss: null,
          child: const DemoPill('Hold'),
        ),
        _premiumTooltip(
          content: const Text('Tap or hold', style: _premiumTextStyle),
          triggerMode: TooltipProTriggerMode.tapAndHold,
          width: 130,
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
          tooltipContent: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Text('Subtle border', style: _premiumTextStyle),
          ),
          tooltipColor: _premiumTooltipColor,
          border: _premiumBorder,
          shadow: _premiumShadow,
          tooltipWidth: 150,
          child: const DemoPill('Border'),
        ),
        TooltipPro(
          tooltipContent: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Text('Deep shadow', style: _premiumTextStyle),
          ),
          tooltipColor: _premiumTooltipColor,
          shadow: TooltipShadowConfig(
            enabled: true,
            color: const Color(0x66000000),
            blurRadius: 22,
            elevation: 12,
          ),
          tooltipWidth: 150,
          child: const DemoPill('Shadow'),
        ),
        TooltipPro(
          tooltipContent: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Text('Pill shape', style: _premiumTextStyle),
          ),
          tooltipColor: _premiumTooltipColor,
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
          tooltipContent: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Text('Glass style', style: _premiumTextStyle),
          ),
          tooltipColor: const Color(0xCC111827),
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
          tooltipWidth: 150,
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
          content: const Text('Soft blur backdrop', style: _premiumTextStyle),
          blur: const TooltipBlurConfig(
            enabled: true,
            sigma: 8,
            includeChild: true,
            color: Color(0x22000000),
          ),
          width: 170,
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
          content: const Text('Compact caret', style: _premiumTextStyle),
          caretWidth: 10,
          caretHeight: 6,
          width: 140,
          child: const DemoPill('Compact'),
        ),
        _premiumTooltip(
          content: const Text('Large caret', style: _premiumTextStyle),
          caretWidth: 22,
          caretHeight: 16,
          width: 140,
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
          content: const Text('Auto dismiss in 2s', style: _premiumTextStyle),
          width: 180,
          autoDismiss: const Duration(seconds: 2),
          child: const DemoPill('2s'),
        ),
        _premiumTooltip(
          content: const Text('Persistent tooltip', style: _premiumTextStyle),
          width: 160,
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
          content: const Text('Shows at tap point', style: _premiumTextStyle),
          width: 170,
          showAtTapPosition: true,
          child: const DemoPill('Tap me'),
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
          tooltipWidth: 220,
          tooltipHeight: 240,
          tooltipColor: _premiumTooltipColor,
          border: _premiumBorder,
          shadow: _premiumShadow,
          animation: _premiumAnimation,
          tooltipContent: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Weekly nutrition', style: _premiumTextStyle),
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
          tooltipWidth: 200,
          tooltipBuilder: (context, hide) {
            return Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _premiumTooltipColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0x22FFFFFF)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x55000000),
                    blurRadius: 16,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Builder tooltip', style: _premiumTextStyle),
                  const SizedBox(height: 6),
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
          tooltipWidth: 180,
          tooltipColor: _premiumTooltipColor,
          border: _premiumBorder,
          shadow: _premiumShadow,
          animation: _premiumAnimation,
          tooltipContent: const Padding(
            padding: EdgeInsets.all(12),
            child: Text('Controlled tooltip', style: _premiumTextStyle),
          ),
          child: const DemoPill('Controller', icon: Icons.tune),
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
