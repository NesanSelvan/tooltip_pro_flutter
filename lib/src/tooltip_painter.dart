import 'package:flutter/material.dart';
import 'package:tooltip_plus_flutter/src/tooltip_enums.dart';

class TooltipPainter extends CustomPainter {
  final Color color;
  final TooltipArrowDirection arrowDirection;
  final TooltipDirection tooltipDirection;
  final bool enableShadow;
  final Color shadowColor;
  final double shadowElevation;
  final double shadowBlurRadius;
  final bool enableBorder;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final double customArrowOffset;
  final double arrowWidth;
  final double arrowHeight;

  TooltipPainter({
    required this.color,
    required this.arrowDirection,
    required this.tooltipDirection,
    this.enableShadow = false,
    this.shadowColor = const Color(0x4D000000),
    this.shadowElevation = 4.0,
    this.shadowBlurRadius = 4.0,
    this.enableBorder = false,
    this.borderColor = Colors.black,
    this.borderWidth = 1.0,
    this.borderRadius = 8.0,
    this.customArrowOffset = 0.5,
    this.arrowWidth = 12.0,
    this.arrowHeight = 10.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = _buildPath(size);

    if (enableShadow) {
      final shadowPaint = Paint()
        ..color = shadowColor
        ..style = PaintingStyle.fill
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowBlurRadius);

      canvas.save();
      canvas.translate(0, shadowElevation);
      canvas.drawPath(path, shadowPaint);
      canvas.restore();
    }

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, paint);

    if (enableBorder) {
      final borderPaint = Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth;
      canvas.drawPath(path, borderPaint);
    }
  }

  Path _buildPath(Size size) {
    final path = Path();
    // Use instance variables instead of constants
    // arrowHeight and arrowWidth are already part of the class

    double radius = borderRadius;
    if (tooltipDirection == TooltipDirection.left ||
        tooltipDirection == TooltipDirection.right) {
      final maxRadius = (size.height - arrowWidth) / 2;
      if (radius > maxRadius) radius = maxRadius;
      if (radius < 0) radius = 0;
    } else {
      final maxRadius = (size.width - arrowWidth) / 2;
      if (radius > maxRadius) radius = maxRadius;
      if (radius < 0) radius = 0;
    }

    double arrowPos;
    final minArrowOffset = radius + arrowWidth / 2;

    if (size.width < minArrowOffset * 2 &&
        (tooltipDirection == TooltipDirection.top ||
            tooltipDirection == TooltipDirection.bottom)) {
      arrowPos = size.width / 2;
    } else if (size.height < minArrowOffset * 2 &&
        (tooltipDirection == TooltipDirection.left ||
            tooltipDirection == TooltipDirection.right)) {
      arrowPos = size.height / 2;
    } else {
      if (tooltipDirection == TooltipDirection.left ||
          tooltipDirection == TooltipDirection.right) {
        final maxPos = size.height - minArrowOffset;
        switch (arrowDirection) {
          case TooltipArrowDirection.left:
            arrowPos = (size.height * 0.2).clamp(minArrowOffset, maxPos);
            break;
          case TooltipArrowDirection.right:
            arrowPos = (size.height * 0.8).clamp(minArrowOffset, maxPos);
            break;
          case TooltipArrowDirection.center:
            arrowPos = size.height * 0.5;
            break;
          case TooltipArrowDirection.custom:
            arrowPos = (size.height * customArrowOffset).clamp(
              minArrowOffset,
              maxPos,
            );
            break;
          case TooltipArrowDirection.none:
            arrowPos = 0;
            break;
        }
      } else {
        final maxPos = size.width - minArrowOffset;
        switch (arrowDirection) {
          case TooltipArrowDirection.left:
            arrowPos = (size.width * 0.2).clamp(minArrowOffset, maxPos);
            break;
          case TooltipArrowDirection.right:
            arrowPos = (size.width * 0.8).clamp(minArrowOffset, maxPos);
            break;
          case TooltipArrowDirection.center:
            arrowPos = size.width * 0.5;
            break;
          case TooltipArrowDirection.custom:
            arrowPos = (size.width * customArrowOffset).clamp(
              minArrowOffset,
              maxPos,
            );
            break;
          case TooltipArrowDirection.none:
            arrowPos = 0;
            break;
        }
      }
    }

    if (arrowDirection == TooltipArrowDirection.none) {
      final bodyRect = Rect.fromLTWH(0, 0, size.width, size.height);
      path.addRRect(RRect.fromRectAndRadius(bodyRect, Radius.circular(radius)));
      return path;
    }

    // Build a single continuous path with arrow integrated
    switch (tooltipDirection) {
      case TooltipDirection.bottom:
        // Arrow points up, body below
        final bodyTop = arrowHeight;
        final bodyBottom = size.height;

        // Start from top-left corner of body (after radius)
        path.moveTo(radius, bodyTop);

        // Top edge with arrow
        path.lineTo(arrowPos - arrowWidth / 2, bodyTop);
        path.lineTo(arrowPos, 0); // Arrow tip
        path.lineTo(arrowPos + arrowWidth / 2, bodyTop);
        path.lineTo(size.width - radius, bodyTop);

        // Top-right corner
        path.arcToPoint(
          Offset(size.width, bodyTop + radius),
          radius: Radius.circular(radius),
        );

        // Right edge
        path.lineTo(size.width, bodyBottom - radius);

        // Bottom-right corner
        path.arcToPoint(
          Offset(size.width - radius, bodyBottom),
          radius: Radius.circular(radius),
        );

        // Bottom edge
        path.lineTo(radius, bodyBottom);

        // Bottom-left corner
        path.arcToPoint(
          Offset(0, bodyBottom - radius),
          radius: Radius.circular(radius),
        );

        // Left edge
        path.lineTo(0, bodyTop + radius);

        // Top-left corner
        path.arcToPoint(
          Offset(radius, bodyTop),
          radius: Radius.circular(radius),
        );
        break;

      case TooltipDirection.top:
        // Arrow points down, body above
        final bodyBottom = size.height - arrowHeight;

        // Start from top-left corner (after radius)
        path.moveTo(radius, 0);

        // Top edge
        path.lineTo(size.width - radius, 0);

        // Top-right corner
        path.arcToPoint(
          Offset(size.width, radius),
          radius: Radius.circular(radius),
        );

        // Right edge
        path.lineTo(size.width, bodyBottom - radius);

        // Bottom-right corner
        path.arcToPoint(
          Offset(size.width - radius, bodyBottom),
          radius: Radius.circular(radius),
        );

        // Bottom edge with arrow
        path.lineTo(arrowPos + arrowWidth / 2, bodyBottom);
        path.lineTo(arrowPos, size.height); // Arrow tip
        path.lineTo(arrowPos - arrowWidth / 2, bodyBottom);
        path.lineTo(radius, bodyBottom);

        // Bottom-left corner
        path.arcToPoint(
          Offset(0, bodyBottom - radius),
          radius: Radius.circular(radius),
        );

        // Left edge
        path.lineTo(0, radius);

        // Top-left corner
        path.arcToPoint(Offset(radius, 0), radius: Radius.circular(radius));
        break;

      case TooltipDirection.right:
        // Arrow points left, body on right
        final bodyLeft = arrowHeight;

        // Start from top-left of body (after radius)
        path.moveTo(bodyLeft + radius, 0);

        // Top edge
        path.lineTo(size.width - radius, 0);

        // Top-right corner
        path.arcToPoint(
          Offset(size.width, radius),
          radius: Radius.circular(radius),
        );

        // Right edge
        path.lineTo(size.width, size.height - radius);

        // Bottom-right corner
        path.arcToPoint(
          Offset(size.width - radius, size.height),
          radius: Radius.circular(radius),
        );

        // Bottom edge
        path.lineTo(bodyLeft + radius, size.height);

        // Bottom-left corner
        path.arcToPoint(
          Offset(bodyLeft, size.height - radius),
          radius: Radius.circular(radius),
        );

        // Left edge with arrow
        path.lineTo(bodyLeft, arrowPos + arrowWidth / 2);
        path.lineTo(0, arrowPos); // Arrow tip
        path.lineTo(bodyLeft, arrowPos - arrowWidth / 2);
        path.lineTo(bodyLeft, radius);

        // Top-left corner
        path.arcToPoint(
          Offset(bodyLeft + radius, 0),
          radius: Radius.circular(radius),
        );
        break;

      case TooltipDirection.left:
        // Arrow points right, body on left
        final bodyRight = size.width - arrowHeight;

        // Start from top-left corner (after radius)
        path.moveTo(radius, 0);

        // Top edge
        path.lineTo(bodyRight - radius, 0);

        // Top-right corner
        path.arcToPoint(
          Offset(bodyRight, radius),
          radius: Radius.circular(radius),
        );

        // Right edge with arrow
        path.lineTo(bodyRight, arrowPos - arrowWidth / 2);
        path.lineTo(size.width, arrowPos); // Arrow tip
        path.lineTo(bodyRight, arrowPos + arrowWidth / 2);
        path.lineTo(bodyRight, size.height - radius);

        // Bottom-right corner
        path.arcToPoint(
          Offset(bodyRight - radius, size.height),
          radius: Radius.circular(radius),
        );

        // Bottom edge
        path.lineTo(radius, size.height);

        // Bottom-left corner
        path.arcToPoint(
          Offset(0, size.height - radius),
          radius: Radius.circular(radius),
        );

        // Left edge
        path.lineTo(0, radius);

        // Top-left corner
        path.arcToPoint(Offset(radius, 0), radius: Radius.circular(radius));
        break;
    }

    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant TooltipPainter oldDelegate) =>
      color != oldDelegate.color ||
      arrowDirection != oldDelegate.arrowDirection ||
      tooltipDirection != oldDelegate.tooltipDirection ||
      enableShadow != oldDelegate.enableShadow ||
      shadowColor != oldDelegate.shadowColor ||
      shadowElevation != oldDelegate.shadowElevation ||
      shadowBlurRadius != oldDelegate.shadowBlurRadius ||
      enableBorder != oldDelegate.enableBorder ||
      borderColor != oldDelegate.borderColor ||
      borderWidth != oldDelegate.borderWidth ||
      borderRadius != oldDelegate.borderRadius ||
      customArrowOffset != oldDelegate.customArrowOffset ||
      arrowWidth != oldDelegate.arrowWidth ||
      arrowHeight != oldDelegate.arrowHeight;
}
