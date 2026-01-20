import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tooltip_plus_flutter/tooltip_plus_flutter.dart';

void main() {
  test('TooltipTarget creates successfully', () {
    // Basic smoke test
    expect(TooltipTarget(child: Container()), isNotNull);
  });

  test('TooltipController creates successfully', () {
    final controller = TooltipController();
    expect(controller, isNotNull);
    expect(controller.isVisible, isFalse);
    controller.dispose();
  });
}
