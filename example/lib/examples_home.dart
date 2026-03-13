import 'package:flutter/material.dart';

import 'example_sections.dart';
import 'example_widgets.dart';

class ExamplesHome extends StatelessWidget {
  const ExamplesHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('tooltip_plus'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 48),
        children: const [
          SectionCard(
            title: 'Factory Constructors',
            icon: Icons.auto_fix_high_rounded,
            child: FactorySection(),
          ),
          SectionCard(
            title: 'Directions',
            icon: Icons.open_with_rounded,
            child: DirectionsSection(),
          ),
          SectionCard(
            title: 'Caret Positions',
            icon: Icons.location_on_rounded,
            child: CaretSection(),
          ),
          SectionCard(
            title: 'Animations',
            icon: Icons.animation_rounded,
            child: AnimationsSection(),
          ),
          SectionCard(
            title: 'Trigger Modes',
            icon: Icons.touch_app_rounded,
            child: TriggerSection(),
          ),
          SectionCard(
            title: 'Border & Shadow',
            icon: Icons.layers_rounded,
            child: BorderShadowSection(),
          ),
          SectionCard(
            title: 'Blur Background',
            icon: Icons.blur_on_rounded,
            child: BlurSection(),
          ),
          SectionCard(
            title: 'Custom Caret Size',
            icon: Icons.straighten_rounded,
            child: CaretSizeSection(),
          ),
          SectionCard(
            title: 'Auto Dismiss',
            icon: Icons.timer_rounded,
            child: AutoDismissSection(),
          ),
          SectionCard(
            title: 'Show at Tap Position',
            icon: Icons.ads_click_rounded,
            child: TapPositionSection(),
          ),
          SectionCard(
            title: 'Custom Content',
            icon: Icons.dashboard_customize_rounded,
            child: CustomContentSection(),
          ),
          SectionCard(
            title: 'Custom Tooltip Builder',
            icon: Icons.build_rounded,
            child: TooltipBuilderSection(),
          ),
          SectionCard(
            title: 'Programmatic Controller',
            icon: Icons.tune_rounded,
            child: ControllerSection(),
          ),
        ],
      ),
    );
  }
}
