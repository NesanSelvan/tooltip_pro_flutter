import 'package:flutter/material.dart';

import 'example_sections.dart';
import 'example_widgets.dart';

class ExamplesHome extends StatelessWidget {
  const ExamplesHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TooltipPro Showcase')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        children: const [
          SectionCard(title: 'Factory Constructors', child: FactorySection()),
          SectionCard(title: 'Directions', child: DirectionsSection()),
          SectionCard(title: 'Caret Positions', child: CaretSection()),
          SectionCard(title: 'Animations', child: AnimationsSection()),
          SectionCard(title: 'Trigger Modes', child: TriggerSection()),
          SectionCard(title: 'Border & Shadow', child: BorderShadowSection()),
          SectionCard(title: 'Blur Background', child: BlurSection()),
          SectionCard(title: 'Custom Caret Size', child: CaretSizeSection()),
          SectionCard(title: 'Auto Dismiss', child: AutoDismissSection()),
          SectionCard(
            title: 'Show at Tap Position',
            child: TapPositionSection(),
          ),
          SectionCard(title: 'Custom Content', child: CustomContentSection()),
          SectionCard(
            title: 'Custom Tooltip Builder',
            child: TooltipBuilderSection(),
          ),
          SectionCard(
            title: 'Programmatic Controller',
            child: ControllerSection(),
          ),
        ],
      ),
    );
  }
}

class TooltipProApp extends StatelessWidget {
  const TooltipProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white, child: ExamplesHome());
  }
}
